class Season < ActiveRecord::Base
  belongs_to :league
  has_many :games
  has_many :season_ratings

  def user_rating user
    result = user.leagues.joins(seasons: :season_ratings)
                 .select('season_ratings.rating as rating')
                 .where('seasons.id': id).first.rating
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
