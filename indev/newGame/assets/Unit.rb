class Unit
	@@array = [
		[
			"{{}}",
			"OOOO"],
		[
			":/\\:",
			"/::\\"],
		[
			"||||",
			"\\__/"]]
	def initialize(player,type,array_num,x,y)
		@x = x
		@y = y
		@player = player
		@type = type
		@tile = Tile.new(@@aray[array_num],"white",@player.get_color)
	end


end