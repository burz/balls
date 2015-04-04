class GodsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_leagues_and_seasons

  def index
    if current_user.god.nil?
      render file: 'public/404.html', status: :unauthorized
    else
      @god_users = User.all.order created_at: :desc
      @god_leagues = League.all.order created_at: :desc
      @god_seasons = Season.all.order created_at: :desc
      @god_games = Game.all.order created_at: :desc
    end
  end
end
