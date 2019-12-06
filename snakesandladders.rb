require "test/unit/assertions"
include Test::Unit::Assertions

SNAKES = { 16 => 6, 46 => 25, 49 => 11, 62 => 19, 64 => 60, 74 => 53, 89 => 68, 92 => 88, 95 => 75, 99 => 80 }
LADDERS = { 2 => 38, 7 => 14, 8 => 31, 15 => 26, 21 => 42, 28 => 84, 36 => 44, 51 => 67, 71 => 91, 78 => 98, 87 => 94 }

class SnakesLadders
	attr_accessor :player_turn
	attr_accessor :player_place

	def initialize(player_turn, player_place)
  		@player_turn = player_turn
  		@player_place = player_place
  		@game_over = false
	end

	def play(die1, die2)
    	@player_place[@player_turn] += (die1 + die2)
    	if @game_over
    		return "Game over!"
    	elsif @player_place[@player_turn] == 100
    		@game_over = true
    		return "Player #{@player_turn + 1} Wins!"
    	elsif @player_place[@player_turn] > 100
    		@player_place[@player_turn] = 200 - @player_place[@player_turn]
    	end
    	if SNAKES.key?(@player_place[@player_turn])
    		#puts "Oh no, a snake"
    		@player_place[@player_turn] = SNAKES[@player_place[@player_turn]]
    	elsif LADDERS.key?(@player_place[@player_turn])
    		#puts "Yes, a ladder!"
    		@player_place[@player_turn] = LADDERS[@player_place[@player_turn]]
    	end
    	message = "Player #{@player_turn + 1} is on square #{@player_place[@player_turn]}"
    	@player_turn = (1 - @player_turn) if die1 != die2
    	return message
  	end
end

game = SnakesLadders.new(0, [36, 23])
assert_equal(game.play(1, 1), "Player 1 is on square 38")
assert_equal(game.play(1, 5), "Player 1 is on square 44")
assert_equal(game.play(6, 2), "Player 2 is on square 31")
assert_equal(game.play(1, 1), "Player 1 is on square 25")
