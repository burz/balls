class RatingsController < ApplicationController
  before_action :authenticate_user!

  def leagues
    @user_leagues = current_user.leagues
  end

  def seasons
    @user_seasons = current_user.seasons
  end
end
