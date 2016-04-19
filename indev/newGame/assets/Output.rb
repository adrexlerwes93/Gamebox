class Output
	@@render_distance = 5
	@@span = 2*@@render_distance+1
	@@lines_printed = 2*@@span + 2
	def initialize
		@@lines_printed.times do puts end
	end

	def overwrite(lines, delete)
	  if delete
	    lines.times do
	      system "printf \"\\033[1A\""
	      system "printf \"\\033[K\""
	    end
	  else
	    system "printf \"\\033[#{lines}A\""  # move cursor n lines up
	  end
	end

	def print_view(player)
		pointer = player.get_pointer
		overwrite(@@lines_printed,false)
		puts "OOOO".white.bg_red
		puts "OOOO".bg_red
		puts "+"+("----"*@@span)+"+"
		for y in (pointer.get_y-@@render_distance)..(pointer.get_y+@@render_distance)
			2.times do |row|
				print "|"
				for x in (pointer.get_x-@@render_distance)..(pointer.get_x+@@render_distance)
					tile = get_tile(x,y)
					out = tile.get(row).dup
					if (x == pointer.get_x && y == pointer.get_y)
						out = pointer.get_l_char.set_bgcolor(tile.get_bgcolor)+
							out[1,2].set_color(tile.get_color).set_bgcolor(tile.get_bgcolor)+
							pointer.get_r_char.set_bgcolor(tile.get_bgcolor)
					else
						out = out.set_color(tile.get_color).set_bgcolor(tile.get_bgcolor)
					end
					print out
				end
				puts "|"
			end
		end
		puts "+"+("----"*@@span)+"+"
	end

	def get_tile(x,y)
		array = $MAP.get_terrain
		if (x<0 || x>=array[0].length || y<0 || y>=array.length)
			tile = $TERRAINS[-1]
		else
			units = $MAP.get_units
			if units[y][x] == 0
				val = array[y][x]
				tile = $TERRAINS[val]
			else
			end
		end
		return tile
	end
end