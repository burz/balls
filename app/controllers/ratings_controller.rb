class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_leagues, only: [:leagues]

  def leagues
    @user = current_user
  end

  def seasons
    @user = current_user
    @user_seasons = @user.seasons
  end
end
