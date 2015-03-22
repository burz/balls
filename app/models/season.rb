class Season < ActiveRecord::Base
  belongs_to :league
  has_many :games
  has_many :season_ratings

  def user_rating user
    result = user.leagues.joins(seasons: :season_ratings)
                 .where('seasons.id': id)
                 .select('season_ratings.*')
                 .where('season_ratings.user_id': user.id)
                 .order('season_ratings.created_at DESC').first
  end

  def user_games user
    user.players.joins(:game).where('games.season_id': id)
  end

  def get_wins user
    user_games(user).where(team: 0).size
  end

  def get_losses user
    user_games(user).where(team: 1).size
  end

  def get_spread user
    get_wins(user).to_s + '/' + get_losses(user).to_s
  end

  def get_ratio user
    get_wins(user) - get_losses(user)
  end

  def rankings
    league.users
  end
end
