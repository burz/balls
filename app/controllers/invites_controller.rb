class InvitesController < ApplicationController
  include Constants

  before_action :authenticate_user!, except: [:join]
  before_action :load_leagues_and_seasons, except: [:join]

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

  def forward_user?
    if not user_signed_in?
      session['user_return_to'] = request.fullpath
      redirect_to new_user_session_path(email: params[:email]), turbolinks: true
      true
    else
      false
    end
  end

  def join
    if not forward_user?
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
                              rating: LEAGUE_START,
                              games_played: 0, wins: 0, losses: 0
          Invite.destroy invite
          league.seasons.each do |season|
            SeasonRating.create user: current_user, season: season,
                                rating: SEASON_START,
                                games_played: 0, wins: 0, losses: 0
          end
          redirect_to controller: :leagues, action: :show, id: league
        end
      end
    end
  end
end
