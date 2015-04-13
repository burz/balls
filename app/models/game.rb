class Game < ActiveRecord::Base
  belongs_to :season
  has_many :players, dependent: :destroy

  def winners
    players.where team: 0
  end

  def losers
    players.where team: 1
  end
end
