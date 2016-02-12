require_relative "string"
require_relative "MapGenerator"

#Array elements:
#0:empty space

#10:housing 	(HH)
#11:left roof	(/H)
#12:right roof	(H\)
#13:top roof	(/\)

#2:tree		(tt)

#3:water		(wW)

#100:Interior
class Map
	def initialize(id,border,array)
		@id = id
		@array = array
		@yBound = @array.length-1
		@xBound = @array[0].length-1
		@border = border
	end

	def get_id;			@id 	end
	def get_array; 		@array 	end
	def get_xBound;		@xBound end
	def get_yBound;		@yBound end
	def get_border;		@border end

	def get_id_at(x,y);	@array[y][x] end

	def find_portal(id)
		for y in (0...@array.length)
			for x in (0...@array[0].length)
				if @array[y][x] == id
					return [x,y]
				end
			end
		end
	end

	def isWalkable(x,y)
		if x < 0 || y < 0 || x > @xBound || y > @yBound
			return false
		else
			return @array[y][x]<=0
		end
	end

	def isOpenDoor(x,y)
		return @array[y][x]<0
	end
end

$mg = MapGenerator.new

$maps=Hash.new
$maps[-1]=Map.new( -1, 20,
   [[ 20, 20, 20, 20, -3, 20, 20, 20, 30, 30, 30, 20, 20, 20, 20, 20, 20, 20, 20, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0, 11, 10, 12,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 30, 30,  0,  0, 10, 10, 10,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0,  0, 10, -2, 10,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 20, 20,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 20, 20,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20]])
$maps[-2]=Map.new( -2, 100,
   [[100,100,100,100,100],
	[100,  0,  0,  0,100],
	[100,  0,  0,  0,100],
	[100,  0,  0,  0,100],
	[100,100, -1,100,100]])
$maps[-3]=Map.new( -3, 20, $mg.generate(-1,60,3,20))

$mg.print_map