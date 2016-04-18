#Not currently used.

class Building

	def initialize(id,location,plot,x,y)
		@id = id
		@location = location
		@plot = plot
		@x = x
		@y = y
		@doorX = x+plot.get_xOffset
		@doorY = y+plot.get_yOffset
		@interior = $maps[id]
	end

	def get_plot;		@plot 		end
	def get_x;			@x 			end
	def get_y;			@y 			end
	def get_interior;	@interior 	end
	def get_id;			@id 		end
end