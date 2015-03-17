class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :league_memberships
  has_many :leagues, through: :league_memberships

  def get_spread
    '20/15'
  end

  def get_ratio
    '+5'
  end

  def admin? league
    league_memberships.where(league_id: league).first.admin
  end
end
