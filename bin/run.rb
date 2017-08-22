require_relative '../config/environment.rb'


new_game = CommandLineInterface.new

new_game.greet
new_game.help
input = ""

while input.downcase != "quit"
  input = new_game.gets_user_input
  case input.downcase
    when "help"
      new_game.help
    when "new game"
      puts "Let's Play!"
       ##Starts a new game.
    else
      puts "Sorry, I didn't understand."
      new_game.help
    end
end

new_game.goodbye
