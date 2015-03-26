class LeaguesController < ApplicationController
  include Constants

  before_action :authenticate_user!
  before_action :set_leagues

  def set_leagues
    @leagues = current_user.leagues
  end

  def index
  end

  def show
    @league = @leagues.find params[:id]
    @seasons = @league.seasons
  end

  def new
  end

  def create
    league = League.create league_params
    LeagueMembership.create user: current_user, league: league, admin: true
    LeagueRating.create user: current_user, league: league,
                        rating: LEAGUE_START,
                        games_played: 0, wins: 0, losses: 0
    render nothing: true
  end

  def admin
    @league = @leagues.find params[:league_id]
    @seasons = @league.seasons
    @users = @league.users
  end

  def create_admin
    league = League.find params[:league_id]
    new_admin = User.find params[:user_id]
    if current_user.admin? league and not league.owner? new_admin
      league_membership = LeagueMembership.where(user: new_admin,
                                                 league: league).first
      league_membership.admin = !league_membership.admin
      league_membership.save
      render nothing: true
    else
      render nothing: true, status: :unauthorized
    end
  end

  def players
    @league = @leagues.find params[:league_id]
    @users = @league.users
  end

  def league_params
    params.require(:league).permit :name, :user_id
  end
end
