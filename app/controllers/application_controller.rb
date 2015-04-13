class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_web_client
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def mobile_browser?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def set_web_client
    if params[:client] == 'web' and mobile_browser?
      params[:client] = 'mob'
    end
  end

  def games_sort x, y
    x_last = x.games.last
    y_last = y.games.last
    if x_last
      if y_last
        -(x_last.created_at <=> y_last.created_at)
      else
        -1
      end
    else
      if y_last
        1
      else
        -(x.created_at <=> y.created_at)
      end
    end
  end

  def load_leagues_and_seasons
    if user_signed_in?
      @leagues = current_user.leagues.sort do |x, y|
        games_sort x, y
      end
      @all_seasons = current_user.seasons.sort do |x, y|
        games_sort x, y
      end
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
