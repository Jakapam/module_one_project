class Pokemon < ActiveRecord::Base
  has_many :rosters
  has_many :trainers, through: :rosters

end
