class Season < ActiveRecord::Base
  belongs_to :league

  def get_spread user
    return '13/15'
  end

  def get_ratio user
    return '-2'
  end

  def rankings
    league.users
  end
end
