require_relative '../config/environment.rb'


game = CommandLineInterface.new

game.greet
game.help
input = ""

while input.downcase != "quit"
  input = game.gets_user_input
  case input.downcase
    when "help"
      game.help
    when "new game"
      puts "Let's Play!"
       ##Starts a new game.
    else
      puts "Sorry, I didn't understand."
      game.help
    end
end

game.goodbye
