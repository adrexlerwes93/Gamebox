Dir["assets/*"].each do |file|
	require_relative file
end

class Game
	def initialize
		@p1 = Player.new("Player 1",$maps[-1],3,3,Input.new(2))
		@out = Output.new
		@out.print_map($maps[-3])
	end

	def run
		@out.start

		while true
			@out.print_view(@p1.get_map,@p1.get_x,@p1.get_y)
			@p1.move
		end
	end

	def quit
		@out.overwrite($WINDOWSIZE,true)
		exit 0
	end
end

$GAME = Game.new
$GAME.run