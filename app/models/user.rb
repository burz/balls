class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :avatar
  has_many :league_memberships
  has_many :leagues, through: :league_memberships
  has_many :seasons, through: :leagues
  has_many :league_ratings
  has_many :season_ratings
  has_many :players
  has_many :games, through: :players

  def last_updated_league
    leagues.joins(:league_ratings).order('league_ratings.created_at DESC').first
  end

  def get_wins
    players.where(team: 0).size
  end

  def get_losses
    players.where(team: 1).size
  end

  def get_spread
    get_wins.to_s + '/' + get_losses.to_s
  end

  def get_ratio
    get_wins - get_losses
  end

  def admin? league
    league_memberships.where(league_id: league).first.admin
  end
end
