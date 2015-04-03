class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def load_leagues_and_seasons
    if user_signed_in?
      @leagues = current_user.leagues.order created_at: :desc
      @all_seasons = current_user.seasons.order created_at: :desc
    else
      @leagues = []
      @all_seasons = []
    end
  end

  def load_league_players
    @league_players = []
    @league_benchwarmers = []
    @league.ratings.each do |rating|
      if rating.games_played == 0
        @league_benchwarmers.push rating
      else
        @league_players.push rating
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
