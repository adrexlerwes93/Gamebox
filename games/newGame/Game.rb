Dir["assets/*"].each do |file|
	require_relative file
end

class Game
	def initialize
		@player = Player.new("Player 1",Input.new(2))
		@output = Output.new

		$RAND = Random.new(261457850940079854015708119209250997973)
		puts $RAND.seed

		@worldCount = $RAND.rand(10)+1

		$SPACE = Array.new(11){Array.new(21,-1)}
		for i in 1..@worldCount
			$WORLDS.push(World.new("World #{i}"))
		end
	end

	def run
		@output.start

		while true
			@output.print_view(@player)
			@player.move
		end
	end

	def quit
		@output.overwrite($WINDOWSIZE,true)
		exit 0
	end
end

$GAME = Game.new
$GAME.run