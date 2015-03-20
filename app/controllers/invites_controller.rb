class InvitesController < ApplicationController
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
end
