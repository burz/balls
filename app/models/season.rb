class Season < ActiveRecord::Base
  belongs_to :league
  has_many :games
  has_many :season_ratings

  def ratings
    inner = 'SELECT MAX(season_ratings.created_at) FROM season_ratings '
    inner = inner + 'WHERE season_ratings.user_id = users.id '
    inner = inner + 'AND season_ratings.season_id = ' + id.to_s
    league.users.joins(:season_ratings)
         .where('season_ratings.created_at = (' + inner + ')')
         .order('season_ratings.rating DESC')
         .select('users.email AS email, season_ratings.*')
  end

  def user_rating user
    result = user.leagues.joins(seasons: :season_ratings)
                 .where('seasons.id': id)
                 .select('season_ratings.*')
                 .where('season_ratings.user_id': user.id)
                 .where('season_ratings.season_id': id)
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
end
