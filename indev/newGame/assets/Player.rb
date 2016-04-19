class Player
	def initialize(name,color)
		@name = name
		@color = color
		@pointer = Pointer.new(0,0)
		@input = Input.new(2)
	end

	def get_pointer;	@pointer 	end
	def get_color;		@color 		end

	def move
		valid = false
		while(!valid)
			x = @pointer.get_x
			y = @pointer.get_y
			inp = @input.read_char
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
				exit 0
			end

			if $MAP.isValidAcre(x,y)
				@pointer.move(x,y)
				valid = true
			end
		end
	end
end