require 'pry'

class Battle
  attr_accessor :enemy, :player, :user
  attr_reader :enemy_test

  def set_up
    # RANDOMLY SELECT POKEMON NAME FROM DATA BASE
    self.enemy = Roster.new_enemy
    self.player = Roster.lead_pokemon
    self.user = CommandLineInterface.current_player
    if self.user.current_roster.size > 1
      puts "Choose your pokemon to battle with!"
      self.user.display_roster
      choice = gets.chomp.to_i
      self.player = self.user.current_roster[choice-1]
    end
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
    move_logic(self.enemy, move, self.player)
  end

  def player_input_valid(input)
    while input <= 0 || input > 4
      puts "Invalid input, please enter a number from 1-4:"
      input = gets.chomp.to_i
    end
    input
  end

  def player_turn
    # user inputs a move choice
    puts "Select a move"
    self.player.move_set.each_with_index do |move_instance, index|
      puts "#{index+1}. #{move_instance.name}"
    end
    input = gets.chomp.to_i
    input = player_input_valid(input)

    move = self.player.move_set[(input - 1)]
    move_logic(self.player, move, self.enemy)
  end

  def pokemon_image_generator(pokemon_id)
    Catpix::print_image "./app/models/image/#{pokemon_id}.png",
      :limit_x => 0.8,
      :limit_y => 0.8,
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

  def clean_up
    if self.enemy.current_hp <= 0
      puts("You defeated the #{self.enemy.name}!")
      self.user.get_pokemon(self.enemy.pokemon_id)
      puts "#{self.enemy.name} was added to your roster!\nYour pokemon are feeling weary af and rest to heal."
      self.user.rosters.each do |pokemon|
        pokemon.current_hp = pokemon.base_hp
      end
      return true
    elsif self.player.current_hp <= 0
      puts("You lost :/")
      exit!(puts "Thanks for playing!")
      return true
    end
    return false
  end

  def header
    puts "#{self.player.name} HP: #{self.player.current_hp} DODGE: #{self.player.dodge}"
    puts "#{self.enemy.name} HP: #{self.enemy.current_hp} DODGE: #{self.enemy.dodge}"
  end

  def play
    puts "you encountered a wild #{self.enemy.name}!!".upcase

    random_enemy = self.enemy.pokemon_id
    your_pokemon = self.player.pokemon_id

    while self.enemy.current_hp > 0 && self.player.current_hp > 0
      puts("\n"+'='*30)
      self.your_pokemon_image(self.player.current_hp, your_pokemon)
      self.header
      self.player_turn
      break if self.clean_up
      sleep(1)
      print('-'*30 + "\n")
      self.header
      self.pokemon_enemy_image(self.enemy.current_hp, random_enemy)
      sleep(1)
      self.enemy_turn
      break if self.clean_up
      sleep(1)
    end
    return true
  end

end
