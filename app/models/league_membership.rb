class LeagueMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_one :league_rating
end
