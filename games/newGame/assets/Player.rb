class Player
	def initialize(name,map,x,y,input)
		@name = name
		@map = map
		@x = x
		@y = y
		@input = input
	end

	def get_map;	@map 	end
	def get_x; 		@x 		end
	def get_y; 		@y 		end

	def move
		x=@x
		y=@y
		inp=@input.read_char
		if inp == @input.enter
			if @map.isOpenDoor(x,y)
				new_id = @map.get_id_at(x,y)
				prev_id = @map.get_id
				@map = $maps[new_id]
				@x, @y = @map.find_portal(prev_id)
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
	end
end