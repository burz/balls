class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_leagues

  def set_leagues
    @leagues = current_user.leagues
  end

  def show
    @user = User.find params[:id]
    @games = @user.games.order(created_at: :desc)
  end
end
