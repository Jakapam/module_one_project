require 'pry'
require 'remedy'
require "tco"
require "rmagick"
require "pry"
require 'catpix'


class Game
  attr_accessor :position

  include Remedy #reads keyboard inputs

  #rock unicode "\u26F0"
  # ghost emoji "😈"
  # ghost emoji "👻"

  def initialize
  	@board = Array.new(100, " ")
    @position = 90
    #character starting position in the corner @board[90]
    @new_row = 0
    #new_row count for new wild pokemon
  end

  def show_board #this is the game board
    puts "-"*30
    puts "|             MENU:          |"
    puts "|   \"R\" ~ SHOW ROSTER        |"
    puts "|   \"N\" ~ New Game           |"
    puts "|   \"K\" ~ Kill weak pokemon  |"
    puts "-"*30
    puts "-"*30
    for i in 0..99 do
      print " #{@board[i]} "
      print "|\n" if (i+1)%10 == 0
    end
    puts "-"*30
    puts "\n"*5
  end

  def get_move #get user input to pass into other methods
    puts "Press up, down, left or right!"
    user_input = Interaction.new
    obstacles #method
    enemy     #method
    @board[9] = "⛩"
    user_input.loop do |key|
      make_move(key.to_s) #method
    end
  end

  def change_board #moves the character piece
      @board[self.position] = "\u26F9"
      show_board
  end

  def obstacles #generates random obstacles
    for i in 1..15 do
        @board[rand(99)] = "🌲"
    end
    for i in 1..5 do
      @board[rand(99)] = "🏠"
    end
  end

  def new_obstacles_drop_down
    new_rows = Array.new(10, " ")
      2.times do
        x = rand(9)
        if x.odd?
          new_rows[x] = "🌲"
        elsif x.even?
          new_rows[x] = "🏠"
        end
      end
    new_wild_pokemon(new_rows) #method
    new_rows.each do |box|
      @board.unshift(box)
    end
  end

  def new_wild_pokemon(new_rows)
    @new_row += 1
    if @new_row === 5
      new_rows[rand(9)] = "😈"
      @new_row = 0
    end
  end

  def board_shift_down
    @board.pop(10)
    for i in 40..49 do
      if @board[i] === "\u26F9"
        @board[i] = " "
      end
    end
    new_obstacles_drop_down
  end

  def enemy #generate random 2 enemies on board
    2.times {@board[rand(99)] = "😈"}
  end

  def make_move(move) #move_person_by_key_input
    @board[self.position] = " "
    case move
      when "up"
        #prevent going over obstacle and board
        if @board[self.position-10] === " " && !(self.position-10 < 39)
          self.position -= 10
          change_board
        #triggers method "fight"
        elsif @board[self.position-10] === "😈"
          #fight_pokemon is the method that prints pokemon img
          fight_pokemon
        end
        if @board[self.position-10] === " " && self.position-10 < 39
          board_shift_down
          @board[self.position] = "\u26F9"
          show_board
        end
      when "down"
        if @board[self.position+10] === " " && self.position + 10 < 100
          self.position += 10
          change_board
        elsif @board[self.position+10] === "😈"
          #fight_pokemon is the method that prints pokemon img
          fight_pokemon
        end
      when "left"                           #if ((i-1)-9)%10 == 0
        if @board[self.position-1] === " " && ((self.position-1)-9)%10 != 0
          self.position -= 1
          change_board
        elsif @board[self.position-1] === "😈"
          #fight_pokemon is the method that prints pokemon img
          fight_pokemon
        end
      when "right"
        if @board[self.position+1] === " " && (self.position + 1)%10 != 0
          self.position += 1
          change_board
        elsif @board[self.position+1] === "😈"
          #fight_pokemon is the method that prints pokemon img
          fight_pokemon
        end
      when /r/i
        puts "Justin's Show Roster Method"
      when /n/i
        CommandLineInterface.new.new_game_setup
      when /k/i
        puts "Kill useless pokemon"
    end
  end

  def fight_pokemon #random_pokemon_generator
      new_battle = Battle.new
      new_battle.play
  end
end
