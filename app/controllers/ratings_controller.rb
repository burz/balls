class RatingsController < ApplicationController
  before_action :authenticate_user!

  def leagues
    @user = current_user
    @user_leagues = @user.leagues
  end

  def seasons
    @user = current_user
    @user_seasons = @user.seasons
  end
end
