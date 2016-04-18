class MapGenerator

	#Returns a randomly generated map.
	def generate(id,span,dir,border)
		@width=5*span
		@height =5*span
		@count = span*span/2
		@array = Array.new(@height){Array.new(@width,border)}
		@digger = {x: @width/2, y: @height/2, count: 1}
		dig
		trim_array
		addPortal(dir)
		return Map.new(id,border,@array)
	end

	#Called by generate. Creates walkable path until count has been reached.
	def dig
		@array[@digger[:y]][@digger[:x]] = 0
		while @digger[:count] < @count
			move($RAND.rand(4))
		end
	end

	#Called by dig. Randomly selects undug area to dig.
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

	#Called by generate. Resizes array to necessary dimensions after dig.
	def trim_array
		yStart, yEnd, xStart, xEnd = Array.new(4,-1)
		for y in (0...@array.length)
			hasZero = false
			for x in (0...@array[0].length)
				if !hasZero
					if @array[y][x] == 0
						hasZero = true
						if yStart < 0
							yStart = y
						end
					end
				end
			end
			if yStart>=0 && yEnd<0 && !hasZero
				yEnd = y-1
			end
		end
		if yStart < 0
			yStart = 0
		end
		if yEnd < 0
			yEnd = @array.length-1
		end
		for x in (0...@array[0].length)
			hasZero = false
			for y in (0...@array.length)
				if !hasZero
					if @array[y][x] == 0
						hasZero = true
						if xStart < 0
							xStart = x
						end
					end
				end
			end
			if xStart>=0 && xEnd<0 && !hasZero
				xEnd = x-1
			end
		end
		if xStart < 0
			xStart = 0
		end
		if xEnd < 0
			xEnd = @array[0].length-1
		end
		tempArray = @array
		@array = Array.new(yEnd-yStart+1){Array.new(xEnd-xStart+1)}
		for y in (0...@array.length)
			for x in (0...@array[0].length)
				@array[y][x] = tempArray[yStart+y][xStart+x]
			end
		end
	end

	#NOT CURRENTLY USED. Randomly adds a portal with specified id to map.
	def addRandomPortal(id)
		looking = true
		while looking
			x,y = [$RAND.rand(@width),$RAND.rand(@height)]
			if @array[y][x] == 0
				@array[y][x] = id
				looking = false
			end
		end
	end

	#Called by generate. Adds a portal to central hub of world, along specified edge.
	def addPortal(dir)
		placed = false
		case dir 
		when 0
			pX=0
			for y in (0...@array.length)
				if !placed && @array[y][0] == 0
					@array[y][0] = -2
					placed = true
				end
			end
		when 1
			for x in (0...@array[0].length)
				if !placed && @array[0][x] == 0
					@array[0][x] = -2
					placed = true
				end
			end
		when 2
			for y in (0...@array.length)
				if !placed && @array[y][@array[0].length-1] == 0
					@array[y][@array[0].length-1] = -2
					placed = true
				end
			end
		when 3
			for x in (0...@array[0].length)
				if !placed && @array[@array.length-1][x] == 0
					@array[@array.length-1][x] = -2
					placed = true
				end
			end
		end
	end

	#TODO
	def clean
		@checked = Array.new(@array.length){Array.new(@array[0].length,false)}
		for y in (0...@checked.length)
			for x in (0...@checked[0].length)
				if @array[y][x] != 0 && !@checked[y][x]
					#TODO: Search areas that are not path and confirm that they are larger than X units.
				end
			end
		end
	end

	#TODO
	def cleanDFS(x,y,cluster)
		  
	end

	#NOT CURRENTLY USED. Prints map as 0's and 1's.
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