class ApplicationController < ActionController::Base
  include Constants
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :set_web_client
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

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

  def load_leagues
    if not @leagues
      @leagues = current_user.leagues
    end
  end

  def load_menu
    user_menu_string = current_user.id.to_s + 'menu'
    @menu = REDIS.get user_menu_string
    if not @menu
      @leagues = current_user.leagues.sort do |x, y|
        games_sort x, y
      end
      @all_seasons = current_user.seasons.sort do |x, y|
        games_sort x, y
      end
      @menu = render_to_string partial: 'common/menu'
      REDIS.set user_menu_string, @menu
      REDIS.expire user_menu_string, REDIS_MENU_TTL
    else
      puts "\033[32mREDIS CACHE: LOADED MENU\033[0m"
    end
  end

  def load_user_games user
    user_games_key = user.id.to_s + 'games'
    @user_games = REDIS.get user_games_key
    if not @user_games
      @games = @user.games.order created_at: :desc
      @user_games = render_to_string partial: 'games/index',
                                     locals: { show_ratings: true }
      REDIS.set user_games_key, @user_games
      REDIS.expire user_games_key, REDIS_USER_GAMES_TTL
    else
      puts "\033[32mREDIS CACHE: LOADED USER GAMES\033[0m"
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

  def after_sign_in_path_for(resource_or_scope)
    path = super
    if path == '/' or path == '/?new_user=true'
      url_for path
    else
      path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    url_for root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
