class Roster < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :trainer
  has_many :moves

  attr_accessor :base_hp, :dodge

  def base_hp
    60
  end


  def self.lead_pokemon
    CommandLineInterface.current_player.lead_pokemon
  end

  def self.default_attributes
    {
    :current_hp => 60,
    :move_1_id => 1,
    :move_2_id => 2,
    :move_3_id => 3,
    :move_4_id => 4
  }
  end

  def self.enemy_attributes
    {:trainer_id => nil,
    :pokemon_id => rand(1..Pokemon.all.size),
    :current_hp => 60,
    :move_1_id => 1,
    :move_2_id => 2,
    :move_3_id => 3,
    :move_4_id => 4}
  end

  def name
    Pokemon.find(self.pokemon_id).name.capitalize
  end

  def self.new_enemy
    self.create(self.enemy_attributes)
  end


  def move_set
    [
      Move.find(self.move_1_id),
      Move.find(self.move_2_id),
      Move.find(self.move_3_id),
      Move.find(self.move_4_id)
    ]
  end

end
