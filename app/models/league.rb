class League < ActiveRecord::Base
  belongs_to :user
  has_many :league_memberships
  has_many :users, through: :league_memberships
  has_many :seasons

  def get_spread user
    '22/15'
  end

  def get_ratio user
    '+7'
  end

  def rankings
    users
  end
end
