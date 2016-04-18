class World
	$WORLDS = []

	@@colors = ["red","green","brown","blue","magenta","cyan","gray","yellow"]

	# def initialize(id, name, seed)
	# 	@id = id
	# 	@name = name
	# 	@seed = seed
	# 	@rand = Random.new(@seed)
	# 	@x = 4
	# 	@y = 7
	# 	@planet = @rand.rand(9)
	# 	@maps = [$maps[-2]]
	# 	$SPACE[@y][@x] = @planet
	# end

	def initialize(name)
		@id = $WORLDS.length
		@x = $RAND.rand(21)
		@y = $RAND.rand(11)
		@color = @@colors[$RAND.rand(8)]
		@maps = [$maps[-2]]
		$SPACE[@y][@x] = @id
		@mg = MapGenerator.new
		for m in 3..6
			@maps.push(@mg.generate(-m,20,m-3,100))
		end
	end

	def addMonster
		map = @maps[$RAND.rand(@maps.length-1)+1]
		monster = Monster.new(map)
		map.get_monsters.push(monster)
	end

	def get_x;		@x 		end
	def get_y;		@y 		end
	def get_maps;	@maps 	end
	def get_color;	@color 	end

	def new_random_world(name)
		id = $WORLDS.length
		seed = Random.new_seed
		$WORLDS.push(World.new(id,name,seed))
	end

	def land
		map = @maps[0]
		x,y = map.find_portal(-1)
		return [map,x,y+1]
	end
end