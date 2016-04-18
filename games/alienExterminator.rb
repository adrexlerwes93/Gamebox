$directory = Dir["../resources/alienExterminator/assets/*"]

$directory.each do |file|
	require_relative file
end

class Game
	def initialize(seed)
		@player = Player.new("Player 1",Input.new(2))
		@output = Output.new
		if seed == nil
			$RAND = Random.new
		else
			$RAND = Random.new(seed.to_i)
		end

		@worldCount = $RAND.rand(10)+1

		$SPACE = Array.new(11){Array.new(21,-1)}
		for i in 1..@worldCount
			$WORLDS.push(World.new("World #{i}"))
		end
	end

	def addMonsters(count)
		monsters = 0
		while monsters < count
			$WORLDS[$RAND.rand(@worldCount)].addMonster
			monsters+=1
		end
	end

	def run
		puts "SEED: #{$RAND.seed}"
		@output.start
		while @player.is_alive
			@output.print_view(@player)
			@player.move
			@player.update
		end
		@output.print_death(@player)
	end

	def quit
		@output.overwrite($WINDOWSIZE+1,true)
		exit 0
	end
end
$GAME = Game.new(ARGV[0])
$MONSTER_COUNT = 100
$SCORE = 0
$GAME.addMonsters($MONSTER_COUNT)
$GAME.run