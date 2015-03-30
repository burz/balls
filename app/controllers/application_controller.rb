class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
