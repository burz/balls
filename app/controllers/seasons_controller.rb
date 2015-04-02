class SeasonsController < ApplicationController
  include Constants

  before_action :authenticate_user!
  before_action :load_leagues_and_seasons, except: [:create]

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
  end

  def create
    season = Season.create season_params
    League.find(season_params[:league_id]).users.each do |user|
      SeasonRating.create user: user, season: season, rating: SEASON_START,
                          games_played: 0, wins: 0, losses: 0
    end
    render nothing: true
  end

  def season_params
    new_params = params.require(:season).permit :name, :end_date, :players_per_team,
                                                :cups_per_team, :number_of_balls,
                                                :additional_rules
    new_params[:league_id] = params[:league_id]
    new_params
  end
end
