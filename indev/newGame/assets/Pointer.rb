class Pointer
	def initialize(x,y)
		@x = x
		@y = y
		@l_char = "[".black
		@r_char = "]".black
	end

	def get_x;		@x 		end
	def get_y;		@y 		end
	def get_l_char;	@l_char	end
	def get_r_char;	@r_char	end

	def move(x,y)
		@x = x
		@y = y
	end
end