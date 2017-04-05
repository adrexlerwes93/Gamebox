class Tile
	@@images
	def initialize(array,color,bgcolor)
		@color = color
		@bgcolor = bgcolor
		@array = array
	end

	def get_color;		@color 		end
	def get_bgcolor;	@bgcolor 	end

	def get(i)
		@array[i]
	end
end

$TERRAINS = {
	-1 => Tile.new([
		"XXXX",
		"XXXX"],"black","black"),
	0 => Tile.new([
		"    ",
		"    "],"black","white"),
	1 => Tile.new([
		"WwWw",
		"wWwW"],"blue","white"),
	2 => Tile.new([
		" /\\ ",
		"//\\\\"],"brown","white")
}
