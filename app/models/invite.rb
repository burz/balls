class Invite < ActiveRecord::Base
  include Tokenable

  belongs_to :league
end
