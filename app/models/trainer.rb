class Trainer < ActiveRecord::Base
  has_many :rosters
  has_many :pokemons, through: :rosters



#assigns a Trainer a pokemon through the Roster with an Id equal to the ID passed in
  def get_pokemon(id)
    new_poke = Roster.create(pokemon_id: id, trainer_id: self.id)
    new_poke = new_poke.update(Roster.default_attributes)
  end

  def remove_pokemon(roster_id)
    Roster.delete(roster_id)
  end

  def call_roster
     self.rosters
  end

  def lead_pokemon
    self.rosters.first
  end

  def self.display_trainer_names
    Trainer.all.each_with_index do |trainer, index|
      puts"#{index+1}. #{trainer.name}"
    end
  end

  def show_roster

  end

end
