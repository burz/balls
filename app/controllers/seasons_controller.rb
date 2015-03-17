class SeasonsController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @seasons = current_user.leagues.where(id: params[:league_id]).seasons
    else
      @seasons = []
    end
  end
end
