class Player
	def initialize(name,input)
		@name = name		
		@input = input	
		@alive = true	
		@world = 0 		
		@onWorld = false	
		@map = nil			
		@x = nil			
		@y = nil			
	end

	def get_name;	@name 		end	#str. Name of player.
	def get_input;	@input 		end	#input. Type of input.
	def is_alive;	@alive 		end #bool. Whether player is alive.
	def get_world;	@world 		end	#int. Index of world currently occupied by player in $WORLDS array.
	def is_onWorld; @onWorld 	end #bool. Whether player is currently on a planet, else in space.
	def get_map;	@map 		end #map. The current map occupied by player.
	def get_x; 		@x 			end	#int. X pos on map.
	def get_y; 		@y 			end #int. Y pos on map.

	def update
		if @onWorld
			@map.get_monsters.each do |monster|
				if monster.isAlive
					monster.move
					if monster.get_x == @x && monster.get_y == @y
						@alive = false
					end
				end
			end
		end
	end

	def move
		if @onWorld
			x=@x
			y=@y
			inp=@input.read_char
			if inp == @input.enter
				if @map.isOpenDoor(x,y)
					if @map.get_id_at(x,y) == -1
						@onWorld=false
					else
						new_id = @map.get_id_at(x,y)
						prev_id = @map.get_id
						@map = $WORLDS[@world].get_maps[(0-new_id)-2]
						@x, @y = @map.find_portal(prev_id)
					end
				else
					attack
				end
			else
				case inp
				when @input.up
					y-=1
				when @input.left
					x-=1
				when @input.down
					y+=1
				when @input.right
					x+=1
				when @input.exit
					$GAME.quit
				when @input.debug_quit
					exit 0
				end

				if @map.isWalkable(x,y)
					@x=x
					@y=y
				end
			end
		else
			inp=@input.read_char
			if inp == @input.enter
				@onWorld = true
				@map, @x, @y = $WORLDS[@world].land
			else
				case inp
				when @input.up
					@world = (@world-1) % $WORLDS.length
				when @input.left
					@world = (@world-1) % $WORLDS.length
				when @input.down
					@world = (@world+1) % $WORLDS.length
				when @input.right
					@world = (@world+1) % $WORLDS.length
				when @input.exit
					$GAME.quit
				when @input.debug_quit
					exit 0
				end
			end
		end
		if $SCORE > 0
			$SCORE-=1
		else
			$SCORE = 0
		end
	end

	def attack
		$SCORE-=9
		@map.get_monsters.each do |monster|
			if monster.isAlive
				if (monster.get_y == @y && (monster.get_x == @x-1 || monster.get_x == @x+1)) || 
				   (monster.get_x == @x && (monster.get_y == @y-1 || monster.get_y == @y+1))
					monster.kill
					$MONSTER_COUNT-=1
					$SCORE+=110
				end
			end
		end
	end
end