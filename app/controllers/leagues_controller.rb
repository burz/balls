class LeaguesController < ApplicationController
  before_action :authenticate_user!

  def index
    @leagues = current_user.leagues
  end

  def show
    @league = current_user.leagues.find params[:id]
    @users = @league.users
    @seasons = @league.seasons
  end

  def new
  end

  def create
    league = League.create league_params
    LeagueMembership.create({ user_id: current_user.id, league_id: league.id, admin: true})
    render nothing: true
  end

  def admin
    @league = current_user.leagues.find params[:league_id]
    @seasons = @league.seasons
    @users = @league.users
  end

  def league_params
    params.require(:league).permit :name, :user_id
  end
end
