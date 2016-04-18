class Monster
	def initialize(map)
		@map = map
		@alive = true
		placed = false
		while !placed
			x = $RAND.rand(@map.get_xBound+1)
			y = $RAND.rand(@map.get_yBound+1)
			if @map.isEmpty(x,y)
				@map.addMonster(x,y)
				@x = x
				@y = y
				placed = true
			end
		end
	end

	def get_x; @x end
	def get_y; @y end
	def isAlive;	@alive end

	def move
		moved = false
		while !moved
			x=@x
			y=@y
			case $RAND.rand(5)
			when 1
				y-=1
			when 2
				y+=1
			when 3
				x-=1
			when 4
				x+=1
			end
			@map.removeMonster(@x,@y)
			if @map.isEmpty(x,y)
				@x=x
				@y=y
				@map.addMonster(@x,@y)
				moved = true
			end
		end
	end

	def kill
		@map.removeMonster(@x,@y)
		@alive = false
	end
end