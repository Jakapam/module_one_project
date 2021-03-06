class CommandLineInterface

  def self.current_player=(player)
    @@current_player = player
  end

  def self.current_player
    @@current_player
  end

  def greet
    pokeball_image
    puts "Welcome to Web-080717 Pokemon! Pokemon is copyrighted by Pokemon Company International. Project is for educational purposes only. Please don't sue us."
  end

  def pokeball_image
    Catpix::print_image "./app/models/image/pokeball.png",
      :limit_x => 0.7,
      :limit_y => 0.7,
      :center_x => false,
      :center_y => false,
      # :bg => "white",
      :bg_fill => true,
      :resolution => "auto"
  end

  def help
    puts " "
    puts "Commands: \n"
    puts "** 'help' for instructions"
    puts "** 'New Game' to start a new game"
    puts "** 'Load Game' to continue a game"
    puts "** 'Delete' to delete a previously played game"
    puts "** 'Quit' to exit"
    puts " "
  end

  def gets_user_name
    puts "What is your name?"
    gets.chomp
  end

  def gets_rival_name
    puts "You have a rival! What's your rival's name?"
    gets.chomp
  end

  def gets_user_input
    puts "What would you like to do?"
    gets.chomp
  end

  def goodbye
    puts "Thanks for playing!"
  end

  def choose_starter_pokemon
    puts "Which Pokemon would you like to start with?"
    puts "1. Bulbasaur"
    puts "2. Charmander"
    puts "3. Squirtle"
    puts "Enter a number (1-3):"
    input = gets.chomp

    case input
    when "1"
      1
    when "2"
      4
    when "3"
      7
    else
      "Sorry, that's not one of the choices!"
      choose_starter_pokemon
    end
  end

  def new_game_setup
    trainer_name = gets_user_name

    print "Hi, #{trainer_name}, "
    rival_name = gets_rival_name

    new_trainer = Trainer.create(name: trainer_name, rival_name: rival_name)
    new_trainer.current_roster = []
    starter_poke_id = choose_starter_pokemon

    new_trainer.get_pokemon(starter_poke_id)
    puts "\nCongratulations! You have a #{Pokemon.find(starter_poke_id).name}!"
    self.class.current_player = new_trainer

  end

  def delete_savefile
    puts "Select which game to delete"
    Trainer.display_trainer_names
    puts "Enter a number:"
    input = gets.chomp
    input = check_input(input)
    Trainer.all[input.to_i-1].delete
  end

  def check_input(input)
    while input.to_i == 0 || !Trainer.all[input.to_i-1]
      puts "Invalid input, please enter valid number:"
      Trainer.display_trainer_names
      input = gets.chomp
    end
  end

  def load_game
    puts "Thanks for coming back!"
    puts "Enter a number to load a game:"

    Trainer.display_trainer_names
    input = gets.chomp
    input = check_input(input)
    player= Trainer.find_by(name: "#{Trainer.all[input.to_i-1].name}")
    player.current_roster = player.rosters
    self.class.current_player = player
  end

  def run_game
    if Game.new.get_move
      sleep(3)
      Runner.run
    end
  end

end
