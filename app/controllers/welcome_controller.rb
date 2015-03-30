class WelcomeController < ApplicationController
  before_action :load_leagues_and_seasons

  def index
  end
end
