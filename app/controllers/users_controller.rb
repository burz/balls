class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_menu

  def show
    @user = User.find params[:id]
    @avatar = Avatar.new
    @user_leagues = @user.leagues
    @user_seasons = @user.seasons
    @games = @user.games.order created_at: :desc
  end

  def edit
  end

  def update
    current_user.name = params[:user][:name]
    current_user.save
    redirect_to url_for(user_path current_user), turbolinks: true
  end
end
