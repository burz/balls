class InvitesController < ApplicationController
  require_relative '../../mixins/constants'

  before_action :authenticate_user!
  before_action :set_leagues

  def set_leagues
    @leagues = current_user.leagues
  end 

  def new
    @league = @leagues.find params[:league_id]
  end

  def create
    email = params[:invite][:email]
    league = @leagues.find params[:league_id]
    invite = Invite.create league: league
    InviteMailer.invite_email(current_user, email, league, invite.token).deliver_now
    render nothing: true
  end

  def join
    invite = Invite.where(token: params[:token]).first
    league = invite.league
    if invite.nil?
      flash[:notice] = 'The token has expired'
      redirect_to controller: :welcome, action: :index
    else
      if league.users.where(id: current_user).first != nil
        flash[:notice] = 'You are already a member of "' + league.name + '"'
        Invite.destroy invite
        redirect_to controller: :leagues, action: :show, id: league
      else
        LeagueMembership.create user: current_user, league: league, admin: false
        LeagueRating.create user: current_user, league: league,
                            rating: Constants::LEAGUE_START,
                            games_played: 0, wins: 0, losses: 0
        Invite.destroy invite
        league.seasons.each do |season|
          SeasonRating.create user: current_user, season: season,
                              rating: Constants::SEASON_START,
                              games_played: 0, wins: 0, losses: 0
        end
        redirect_to controller: :leagues, action: :show, id: league
      end
    end
  end
end
