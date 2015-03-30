class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_leagues_and_seasons

  def show
    @user = User.find params[:id]
    @avatar = Avatar.new
    @games = @user.games.order(created_at: :desc)
    season_ratings = @user.seasons.map do |season|
      data = SeasonRating.where(user: @user, season: season).map do |rating|
        [rating.created_at, rating.rating]
      end
      { name: season.name, data: data }
    end
    league_ratings = @user.leagues.map do |league|
      data = LeagueRating.where(user: @user, league: league).map do |rating|
        [rating.created_at, rating.rating]
      end
      { name: league.name, data: data }
    end
    @ratings = season_ratings.concat league_ratings
  end
end
