class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      load_menu
      load_leagues
      if @leagues.size > 0
        @league = current_user.last_updated_league
        load_league_page @league
        render template: 'leagues/show'
      else
        render template: 'leagues/index'
      end
    else
      render template: 'welcome/homepage'
    end
  end
end
