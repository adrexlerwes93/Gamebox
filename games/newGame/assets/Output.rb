class Output

	$WINDOWSIZE=13

	@@PLANETS = {
		-1=>'  ',
		0=>'()'.white,
		1=>'()'.red,
		2=>'()'.green,
		3=>'()'.brown,
		4=>'()'.blue,
		5=>'()'.magenta,
		6=>'()'.cyan,
		7=>'()'.gray,
		8=>'()'.yellow
	}

	@@CHAR_KEY = {
		#portal
		-1=>'[]',
		#flooring
		0=>'  ',
		#players
		1=>'{}',
		#housing
		10=>'HH'.brown,
		11=>'/H'.brown,
		12=>'H\\'.brown,
		13=>'/\\'.brown,
		#trees
		20=>'tt'.green,
		#water
		30=>'wW'.blue,
		#walls
		100=>'  '.bg_black
	}
	#portal
	@@CHAR_KEY.default = 'XX'

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

	def start
		$WINDOWSIZE.times do puts end
	end

	def print_char(number)
		print @@CHAR_KEY[number]
	end

	def print_planet(number, bold)
		if bold
			print @@PLANETS[number].bg_black.bold.reverse_color
		else
			print @@PLANETS[number].bg_black
		end
	end

	def print_map(map)
		map.get_array.each do |row|
			row.each do |number|
				print_char(number)
			end
			puts
		end
	end

	def print_view(player)
		if player.is_onWorld
			print_view_land(player.get_map,player.get_x,player.get_y)
		else
			print_view_space($WORLDS[player.get_world])
		end
	end

	def print_view_land(map,x0,y0)
		overwrite($WINDOWSIZE,false)
		puts "+------------------------------------------+"
		for y in (y0-5)..(y0+5)
			print "|"
			for x in (x0-10)..(x0+10)
				if(x<0 || x>map.get_xBound || y<0 || y>map.get_yBound)
					print_char(map.get_border)
				elsif(x==x0 && y==y0)
					print_char(1)
				else
					val = map.get_array[y][x]
					if val < 0
						print_char(-1)
					else
						print_char(map.get_array[y][x])
					end
				end
			end
			puts "|"
		end
		puts "+------------------------------------------+"
	end

	def print_view_space(world)
		overwrite($WINDOWSIZE,false)
		puts "+------------------------------------------+"
		for y in 0..10
			print "|"
			for x in 0..20
				val = $SPACE[y][x]
				if x == world.get_x && y == world.get_y
					print_planet(val,true)
				else
					print_planet(val,false)
				end
			end
			puts "|"
		end
		puts "+------------------------------------------+"
	end
end