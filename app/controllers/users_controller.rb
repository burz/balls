class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_leagues_and_seasons

  def show
    @user = User.find params[:id]
    @avatar = Avatar.new
    @games = @user.games.order(created_at: :desc)
    @user_leagues = @user.leagues
    @user_seasons = @user.seasons
    @league_ratings = @user_leagues.map do |league|
      data = LeagueRating.where(user: @user, league: league).map do |rating|
        [rating.created_at, rating.rating]
      end
      { name: league.name, data: data }
    end
    @season_ratings = @user_seasons.map do |season|
      data = SeasonRating.where(user: @user, season: season).map do |rating|
        [rating.created_at, rating.rating]
      end
      { name: season.name, data: data }
    end
  end

  def edit
  end

  def update
    current_user.name = params[:user][:name]
    current_user.save
    redirect_to user_path(current_user)
  end
end
