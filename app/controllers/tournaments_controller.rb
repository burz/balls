class TournamentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_menu

  def index
  end
end
