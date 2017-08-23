require 'pry'

class Battle
  attr_accessor :enemy, :player
  attr_reader :enemy_test

  def set_up
    # RANDOMLY SELECT POKEMON NAME FROM DATA BASE
    self.enemy = Roster.new_enemy
    self.player = Roster.lead_pokemon
    puts "set up success"
  end

  def initialize
    self.set_up
  end

  def dodge?(move)
    roll = rand(1..100)
    roll <= move.dodge_chance
  end

  def move_logic(acting_party, move, opposition)
    # executes results of passed in move instance
    if move.category === "a"
      puts "#{acting_party.name} is attacking #{opposition.name}"
      if opposition.dodge === true
        puts "#{acting_party.name}'s attack missed!"
        opposition.dodge = false
      else
        opposition.current_hp -= move.damage
      end
    elsif move.category === "d"
      dodge?(move) ? acting_party.dodge=true : acting_party.dodge=false
        puts "#{acting_party.name} prepared to dodge!"
    elsif move.category === "h"
      if acting_party.base_hp > acting_party.current_hp
        puts "#{acting_party.name} healed for #{move.heal}"
        acting_party.current_hp += move.heal
        if acting_party.current_hp > acting_party.base_hp
          acting_party.current_hp = acting_party.base_hp
        end
      else
        puts "#{acting_party.name} is already at full health"
      end
    elsif move.category === "t"
      puts "#{acting_party.name} taunted #{opposition.name}"
    end
  end


  def enemy_turn
    # randomly select a move for the enemy
    random_move = rand(0..3)
    move = self.enemy.move_set[random_move]
    puts move.class
    move_logic(self.enemy, move, self.player)
  end

  def player_input_valid?(input)
    [1,2,3,4].include?(input)
  end

  def player_turn
    # user inputs a move choice
    puts "Select a move"
    self.player.move_set.each_with_index do |move_instance, index|
      puts "#{index+1}. #{move_instance.name}"
    end
    input = STDIN.gets.chomp.to_i
    self.player_input_valid?(input) ? true : self.player_turn
    move = self.player.move_set[(input - 1)]
    puts move.class
    move_logic(self.player, move, self.enemy)
  end

  def clean_up
    if self.enemy.current_hp <= 0
      puts("You defeated the #{self.enemy.name}!")
      # self.enemy.trainer_id = CommandLineInterface.current_player.id
      # self.enemy.current_hp = 60
      return true
    elsif self.player.current_hp <= 0
      puts("You lost :/")
      return true
    end
    return false
  end

  def pokemon_image_generator(pokemon_id)
    Catpix::print_image "./app/models/image/#{pokemon_id}.png",
      :limit_x => 0.35,
      :limit_y => 0.35,
      :center_x => false,
      :center_y => false,
      # :bg => "white",
      :bg_fill => true,
      :resolution => "auto"
  end

  def pokemon_enemy_image(hp, random_enemy)
      pokemon_image_generator(random_enemy)
      #Marlan needs to pass in hp as arg
      print ((" "*(hp/2)).bg "#eb443b") + " HP #{hp}\n"
  end

  def your_pokemon_image(hp, your_pokemon)
      pokemon_image_generator(your_pokemon)
      #Marlan needs to pass in hp as arg
      print ((" "*(hp/2)).bg "#eb443b") + " HP #{hp}\n"
  end

  def play
    puts "you encountered a wild #{self.enemy.name}!!".upcase
    random_enemy = rand(1..3)
    your_pokemon = self.player.pokemon.id
    while self.enemy.current_hp > 0 && self.player.current_hp > 0
      puts("\n"+'='*30)
      puts "#{self.player.name} HP: #{self.player.current_hp} DODGE: #{self.player.dodge}"
      self.your_pokemon_image(self.player.current_hp, your_pokemon)
      puts "#{self.enemy.name} HP: #{self.enemy.current_hp} DODGE: #{self.enemy.dodge}"
      self.pokemon_enemy_image(self.enemy.current_hp, random_enemy)
      self.player_turn
      break if self.clean_up
      print('-'*30 + "\n")
      self.enemy_turn
      break if self.clean_up
      print("\n"+'='*30)
    end
    puts "Battle ended"
    return true
  end

end
