class Map
	def initialize
		@start_points = [[0,0],[8,8]]
		@terrain = generate_terrain(9,9)
		@units = Array.new(@terrain.length){Array.new(@terrain[0].length,0)}
	end

	def get_terrain; 	@terrain 	end
	def get_units;		@units 		end

	def isValidAcre(x,y)
		return !(x<0 || x>=@terrain[0].length || y<0 || y>=@terrain.length)
	end

	def unitAt(x,y)
		if (x<0 || x>=@units[0].length || y<0 || y>=@units.length)
			return 0
		else
			return @units[y][x]
		end
	end

	def generate_terrain(height,width)
		terrain = Array.new(height){Array.new(width,0)}
		height.times do |i|
			terrain[i][width/2] = 1
		end
		width.times do |i|
			terrain[height/2][i] = 2
		end
		return terrain
	end

	def add_unit(x,y)
		
end