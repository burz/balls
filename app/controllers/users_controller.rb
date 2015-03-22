class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_leagues

  def set_leagues
    @leagues = current_user.leagues
  end

  def show
    @user = User.find params[:id]
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
