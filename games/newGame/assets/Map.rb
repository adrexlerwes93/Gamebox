require_relative "string"
require_relative "MapGenerator"
class Map
	def initialize(id,border,array)
		@id = id
		@array = array
		@yBound = @array.length-1
		@xBound = @array[0].length-1
		@border = border
		@monsters = []
	end

	def get_id;			@id 	end
	def get_array; 		@array 	end
	def get_xBound;		@xBound end
	def get_yBound;		@yBound end
	def get_border;		@border end
	def get_monsters;	@monsters end

	#returns the value at a given point on the map.
	def get_id_at(x,y);	@array[y][x] end


	#returns the coordinates of the portal with the specified id.
	def find_portal(id)
		for y in (0...@array.length)
			for x in (0...@array[0].length)
				if @array[y][x] == id
					return [x,y]
				end
			end
		end
	end

	#adds a monster to the map at the given coordinates.
	def addMonster(x,y)
		@array[y][x] = 2
	end

	#removes monster at given coordinates from map.
	def removeMonster(x,y)
		@array[y][x] = 0
	end

	#returns true if space at given coordinates can be walked on by the player. (empty,portal,enemy)
	def isWalkable(x,y)
		if x < 0 || y < 0 || x > @xBound || y > @yBound
			return false
		else
			return @array[y][x]<=2
		end
	end

	#returns true if space at given coordinates is empty.
	def isEmpty(x,y)
		if x < 0 || y < 0 || x > @xBound || y > @yBound
			return false
		else
			return @array[y][x]==0
		end
	end

	#returns true 
	def isOpenDoor(x,y)
		return @array[y][x]<0
	end
end

$mg = MapGenerator.new

#Hash of default maps.
$maps=Hash.new
$maps[-3]=Map.new( -3, 20,
   [[ 20, 20, 20, 20, -6, 20, 20, 20, 30, 30, 30, 20, 20, 20, 20, 20, 20, 20, 20, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0, 11, 10, 12,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 30, 30,  0,  0, 10, 10, 10,  0,  0,  0, 20], 
	[ -5,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0,  0, 10, -1, 10,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 20, 20,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 20, 20,  0,  0,  0,  0,  0,  0,  0,  0, -3], 
	[ 20,  0,  0,  0,  0,  0,  0,  0, 30, 30,  0,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 20], 
	[ 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, -4, 20, 20, 20, 20, 20, 20, 20, 20, 20]])
#Current default landing map
$maps[-2]=Map.new( -2,100,
   [[100,100,100,100, -6,100,100,100,100,100,100,100,100],
    [100,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,100],
    [100,  0,  0,  0,  0,  0, 43,  0,  0,  0,  0,  0,100],
    [100,  0,  0,  0,  0, 45, 47, 46,  0,  0,  0,  0,100],
    [ -5,  0,  0,  0,  0, 41, 44, 42,  0,  0,  0,  0,100],
    [100,  0,  0,  0,  0, 40, 40, 40,  0,  0,  0,  0,100],
    [100,  0,  0,  0, 45, 40, -1, 40, 46,  0,  0,  0,100],
    [100,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, -3],
    [100,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,100],
    [100,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,100],
    [100,100,100,100,100,100,100, -4,100,100,100,100,100]])
$maps[-1]=Map.new( -1,100,
   [[100,100,100,100,100],
	[100,  0,  0,  0,100],
	[100,  0,  0,  0,100],
	[100,  0,  0,  0,100],
	[100,100, -2,100,100]])