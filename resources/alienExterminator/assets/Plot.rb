#not currently used

class Plot
	def initialize(array)
		@array=array
		@xOffset,@yOffset = calcOffsets(array)
	end

	def get_array;		@array 		end
	def get_xOffset;	@xOffset 	end
	def get_yOffset;	@yOffset 	end

	def calcOffsets(array)
		for y in (0...array.length)
			for x in (0...array[0].length)
				if array[y][x] == -1
					return [x,y]
				end
			end
		end
		return [-1,-1]
	end
end

$plots = Hash.new
$plots[:plot1] = Plot.new([
		[11,10,12],
		[10,10,10],
		[10,-1,10]])
$plots[:plot2] = Plot.new([
		[ 0, 0,13, 0, 0],
		[ 0,11,10,12, 0],
		[11,10,-1,10,12]])		
