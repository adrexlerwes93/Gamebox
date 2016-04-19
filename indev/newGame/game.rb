$directory = Dir["assets/*"]

$directory.each do |file|
	require_relative file
end

class Game
	$MAP = nil
	def initialize
		$MAP = Map.new
		@out = Output.new
		@player = Player.new
	end

	def run
		while true
			@out.print_view(@player)
			@player.move
		end
	end
end

game = Game.new
game.run