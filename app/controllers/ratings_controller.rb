class RatingsController < ApplicationController
  before_action :authenticate_user!

  def leagues
    @leagues = current_user.leagues
  end

  def seasons
    @all_seasons = current_user.seasons
  end
end
