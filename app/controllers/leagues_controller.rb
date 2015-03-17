class LeaguesController < ApplicationController
  before_action :authenticate_user!

  def index
    @leagues = current_user.leagues
  end

  def show
    @league = current_user.leagues.find(params[:id])
    @seasons = @league.seasons
  end

  def new
  end

  def create
    League.create league_params
    render nothing: true
  end

  def league_params
    params.require(:league).permit :name, :user_id
  end
end
