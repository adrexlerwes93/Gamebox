class World
	$WORLDS = []

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
		@seed = Random.new_seed
		@rand = Random.new(@seed)
		@x = @rand.rand(21)
		@y = @rand.rand(11)
		@planet = @rand.rand(9)
		@maps = [$maps[-2]]
		$SPACE[@y][@x] = @planet
		@mg = MapGenerator.new
		for m in 3..6
			#@maps.push(Map.new( -3, 20, $mg.generate(-1,60,3,20)))
			@maps.push(@mg.generate(-m,20,m-3,20))
		end

	end

	def get_x;		@x 		end
	def get_y;		@y 		end
	def get_maps;	@maps 	end

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