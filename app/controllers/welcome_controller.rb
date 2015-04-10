class WelcomeController < ApplicationController
  before_action :load_leagues_and_seasons

  def index
    if user_signed_in?
      if @leagues.size > 0
        @league = current_user.last_updated_league
        @seasons = @league.seasons.order created_at: :desc
        load_league_players
        render template: 'leagues/show'
      else
        render template: 'leagues/index'
      end
    else
      render template: 'welcome/homepage'
    end
  end
end
