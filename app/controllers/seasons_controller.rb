class SeasonsController < ApplicationController
  include Constants

  before_action :authenticate_user!
  before_action :load_leagues_and_seasons

  def index
    @league = current_user.leagues.find params[:league_id]
    @seasons = @league.seasons.order created_at: :desc
  end

  def show
    @league = current_user.leagues.find params[:league_id]
    @season = @league.seasons.find params[:id]
    @games = @season.games.order(created_at: :desc)
  end

  def new
    @league = current_user.leagues.find params[:league_id]
    @season = Season.new
  end

  def create
    season = Season.create season_params
    League.find(season_params[:league_id]).users.each do |user|
      SeasonRating.create user: user, season: season, rating: SEASON_START,
                          games_played: 0, wins: 0, losses: 0
    end
    redirect_to league_season_path(season.league, season)
  end

  def edit
    @league = current_user.leagues.find params[:league_id]
    @season = current_user.seasons.find params[:id]
  end

  def update
    season = current_user.seasons.find params[:id]
    season.update_attributes season_params
    redirect_to league_season_path(season.league, season)
  end

  protected

  def season_params
    new_params = params.require(:season).permit :name, :end_date, :players_per_team,
                                                :cups_per_team, :number_of_balls,
                                                :additional_rules
    new_params[:league_id] = params[:league_id]
    new_params
  end
end
