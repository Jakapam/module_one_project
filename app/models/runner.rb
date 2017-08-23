class Runner

  def self.run
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
          game.new_game_setup
          game.run_game #Drop player into David's WorldMap

        when "load game"
          if Trainer.all.count == 0
            puts "No previous games. Starting a new game!"
            game.new_game_setup
            game.run_game #Drop player into David's WorldMap
          else
            game_check = game.load_game
            game.run_game #Drop player into David's WorldMap
          end

        when "delete"
          if Trainer.all.count == 0
            puts "Sorry, there is no save data to delete."
          else
            puts "This will delete your save game data. Are you sure? (y/n)"
            y_or_n = gets.chomp
            if y_or_n.downcase == "y"
              deleted_player = game.delete_savefile
              puts "#{deleted_player.name}'s data deleted."
            else
              input = "help"
            end
          end

        else
          puts "Sorry, I didn't understand."
          game.help
        end

    end

    game.goodbye
  end

end
