Dir["assets/*"].each do |file|
	require_relative file
end

class Game
	def initialize
		@p1 = Player.new("Player 1",Input.new(2))
		@out = Output.new
	end

	def run
		@out.start

		while true
			@out.print_view(@p1)
			@p1.move
		end
	end

	def quit
		@out.overwrite($WINDOWSIZE,true)
		exit 0
	end
end

$SPACE = Array.new(11){Array.new(21,-1)}
for i in 1..4
	$WORLDS.push(World.new("World #{i}"))
end

$GAME = Game.new
$GAME.run