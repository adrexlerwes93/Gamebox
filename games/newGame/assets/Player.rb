class Player
	def initialize(name,input)
		@name = name		
		@input = input		
		@world = 0 		
		@onWorld = false	
		@map = nil			
		@x = nil			
		@y = nil			
	end

	def get_name;	@name 		end	#str. Name of player.
	def get_input;	@input 		end	#input. Type of input.
	def get_world;	@world 		end	#int. Index of world currently occupied by player in $WORLDS array.
	def is_onWorld; @onWorld 	end #bool. Whether player is currently on a planet, else in space.
	def get_map;	@map 		end #map. The current map occupied by player.
	def get_x; 		@x 			end	#int. X pos on map.
	def get_y; 		@y 			end #int. Y pos on map.

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
				end
			end
		end
	end
end