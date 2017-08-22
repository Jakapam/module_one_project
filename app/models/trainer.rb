class Trainer < ActiveRecord::Base
  has_many :rosters
  has_many :pokemons, through: :rosters
end
