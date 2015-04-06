class LeaguesController < ApplicationController
  include Constants

  before_action :authenticate_user!
  before_action :load_leagues_and_seasons, except: [:create, :create_admin]

  def index
  end

  def show
    @league = @leagues.find params[:id]
    @seasons = @league.seasons.order created_at: :desc
    load_league_players
  end

  def new
  end

  def create
    league = League.create league_params
    LeagueMembership.create user: current_user, league: league, admin: true
    LeagueRating.create user: current_user, league: league,
                        rating: LEAGUE_START,
                        games_played: 0, wins: 0, losses: 0
    render json: { path: new_league_invite_path(league, new_league: true) }
  end

  def admin
    @league = @leagues.find params[:league_id]
    @seasons = @league.seasons.order created_at: :desc
    @users = @league.users.order name: :asc
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
    @users = @league.users.order name: :asc
  end

  def league_params
    params.require(:league).permit :name, :user_id
  end
end
