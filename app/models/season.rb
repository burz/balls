class Season < ActiveRecord::Base
  belongs_to :league

  def get_spread user
    '13/15'
  end

  def get_ratio user
    '-2'
  end

  def rankings
    league.users
  end
end
