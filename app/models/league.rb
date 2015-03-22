class League < ActiveRecord::Base
  belongs_to :user
  has_many :league_memberships
  has_many :users, through: :league_memberships
  has_many :invites
  has_many :seasons
  has_many :league_ratings

  def ratings
    inner = 'SELECT MAX(league_ratings.created_at) FROM league_ratings '
    inner = inner + 'WHERE league_ratings.user_id = users.id'
    users.joins(:league_ratings)
         .where('league_ratings.created_at = (' + inner + ')')
         .group('users.id')
         .order('league_ratings.rating DESC')
         .select('users.email as email, league_ratings.*')
  end

  def owner? other_user
    other_user == user
  end

  def user_rating user
    user.leagues.joins(:league_ratings)
        .select('league_ratings.*')
        .where('league_ratings.user_id': user.id)
        .order('league_ratings.created_at DESC').first
  end

  def user_games user
    user.players.joins(:game).joins(game: :season).where('seasons.league_id': id)
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
    users
  end
end
