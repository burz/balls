class TournamentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_leagues_and_seasons

  def index
  end
end
