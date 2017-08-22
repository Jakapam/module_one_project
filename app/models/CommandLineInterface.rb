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

  def gets_user_input
    puts "What would you like to do?"
    gets.chomp
  end

  def goodbye
    puts "Thanks for playing!"
  end

end