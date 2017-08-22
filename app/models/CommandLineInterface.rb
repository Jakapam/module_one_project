class CommandLineInterface

  def greet
   puts "Welcome to Web-080717 Pokemon! Pokemon is copyrighted by Pokemon Company International.
    \nProject is for educational purposes only. Please don't sue us.
    \nMain Menu"
  end

  def help
    puts " "
    puts "Commands: \n"
    puts "** 'help' for instructions"
    puts "** 'New Game' to start a new game"
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
    puts "Which Pokemon would you like?"
  end

  def new_game_setup
    trainer_name = gets_user_name
    rival_name = gets_rival_name
    new_trainer = Trainer.new(name: trainer_name, rival_name: rival_name)
  end

end
