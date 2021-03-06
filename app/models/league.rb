class League < ActiveRecord::Base
  belongs_to :user
  has_many :league_memberships, dependent: :destroy
  has_many :users, through: :league_memberships
  has_many :invites, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :games, through: :seasons
  has_many :league_ratings, dependent: :destroy

  def ratings
    inner = 'SELECT MAX(league_ratings.created_at) FROM league_ratings '
    inner = inner + 'WHERE league_ratings.user_id = users.id '
    inner = inner + 'AND league_ratings.league_id = ' + id.to_s
    users.joins(:league_ratings)
         .where('league_ratings.created_at = (' + inner + ')')
         .order('league_ratings.rating DESC')
         .select('users.name AS name, league_ratings.*')
  end

  def owner? other_user
    other_user == user
  end

  def user_ratings user
    user.leagues.joins(:league_ratings)
        .select('league_ratings.*')
        .where('league_ratings.user_id': user.id)
        .where('league_ratings.league_id': id)
        .order('league_ratings.created_at DESC')
  end

  def user_rating user
    user_ratings(user).first
  end

  def user_ranking user
    ratings.where('league_ratings.games_played > 0').each_with_index do |rating, i|
      if rating.user_id == user.id
        return i + 1
      end
    end
    'Benchwarmer'
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
