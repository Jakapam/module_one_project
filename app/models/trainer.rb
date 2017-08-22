class Trainer < ActiveRecord::Base
  has_many :rosters
  has_many :pokemons, through: :rosters



#assigns a Trainer a pokemon through the Roster with an Id equal to the ID passed in
  def get_pokemon(id)
    new_poke = Roster.create(pokemon_id: id, trainer_id: self.id)
    new_poke = new_poke.update(Roster.default_attributes)
  end

end
