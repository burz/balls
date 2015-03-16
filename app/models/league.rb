class League < ActiveRecord::Base
  belongs_to :user
  has_many :users

  def get_spread user
    return '22/15'
  end

  def get_ratio user
    return '+7'
  end
end
