class SeasonsController < ApplicationController
  before_action :authenticate_user!

  def index
    @league = current_user.leagues.find params[:league_id]
    @seasons = @league.seasons
  end

  def show
    @league = current_user.leagues.find params[:league_id]
    @season = @league.seasons.find params[:id]
  end

  def new
    @league = current_user.leagues.find params[:league_id]
  end

  def create
    Season.create season_params
    render nothing: true
  end

  def season_params
    new_params = params.require(:season).permit :name, :end_date, :players_per_team,
                                                :cups_per_team, :additional_rules
    new_params[:league_id] = params[:league_id]
    new_params
  end
end
