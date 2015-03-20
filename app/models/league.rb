class League < ActiveRecord::Base
  belongs_to :user
  has_many :league_memberships
  has_many :users, through: :league_memberships
  has_many :seasons

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
