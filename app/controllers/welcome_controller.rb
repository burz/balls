class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @leagues = current_user.leagues
    else
      @leagues = []
    end
  end
end
