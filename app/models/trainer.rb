class Trainer
  has_many :rosters
  has_many :pokemons, through: :rosters
end
