class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_menu

  def show
    @user = User.find params[:id]
    @user_leagues = @user.leagues
    @avatar = Avatar.new
    graph_data_key = @user.id.to_s + 'graph'
    @graph_data = REDIS.get graph_data_key
    if not @graph_data
      @user_seasons = @user.seasons
      @graph_data = render_to_string partial: 'users/graph_data'
      REDIS.set graph_data_key, @graph_data
      REDIS.expire graph_data_key, REDIS_GRAPH_TTL
    else
      puts "\033[32mREDIS CACHE: LOADED GRAPH DATA \"#{graph_data_key}\033[0m"
    end
    load_user_games @user
  end

  def edit
  end

  def update
    current_user.name = params[:user][:name]
    current_user.save
    redirect_to url_for(user_path current_user), turbolinks: true
  end
end
