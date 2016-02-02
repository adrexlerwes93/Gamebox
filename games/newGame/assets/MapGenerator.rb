class MapGenerator

	def generate(id,width,height,border)
		@width=width
		@height = height
		@array = Array.new(height){Array.new(width,border)}
		@digger = {x: width/2, y: height/2, count: 1}
		dig
		addPortal(id)
		return @array
	end

	def dig
		@array[@digger[:y]][@digger[:x]] = 0
		while @digger[:count] < @width*@height/2
			move(Random.rand(4))
		end
	end

	def move(dir)
		case dir 
		when 0
			if @digger[:x]>0
				if @array[@digger[:y]][@digger[:x]-1] != 0
					@array[@digger[:y]][@digger[:x]-1] = 0
					@digger[:count]+=1
				end
				@digger[:x]-=1
			end
		when 1
			if @digger[:y]>0
				if @array[@digger[:y]-1][@digger[:x]] != 0
					@array[@digger[:y]-1][@digger[:x]] = 0
					@digger[:count]+=1
				end
				@digger[:y]-=1
			end
		when 2
			if @digger[:x]<@width-1
				if @array[@digger[:y]][@digger[:x]+1] != 0
					@array[@digger[:y]][@digger[:x]+1] = 0
					@digger[:count]+=1
				end
				@digger[:x]+=1
			end
		when 3
			if @digger[:y]<@height-1
				if @array[@digger[:y]+1][@digger[:x]] != 0
					@array[@digger[:y]+1][@digger[:x]] = 0
					@digger[:count]+=1
				end
				@digger[:y]+=1
			end
		end
	end

	def addPortal(id)
		looking = true
		while looking
			x,y = [Random.rand(@width),Random.rand(@height)]
			if @array[y][x] == 0
				@array[y][x] = id
				looking = false
			end
		end
	end



	def print_map
		@array.each do |row|
			row.each do |cell|
				if cell < 0
					print 5
				elsif cell > 0
					print 1
				else
					print 0
				end
			end
			puts
		end
	end
end