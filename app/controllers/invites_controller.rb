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
    InviteMailer.invite_email(current_user, email, league).deliver_now
    render nothing: true
  end
end
