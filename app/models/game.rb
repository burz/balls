class Game < ActiveRecord::Base
  has_many :players

  def winners
    players.where team: 0
  end

  def losers
    players.where team: 1
  end
end
