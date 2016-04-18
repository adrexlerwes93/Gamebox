class Output

	$WINDOWSIZE=14

	@@CHAR_KEY = {
		#portal
		-1=>'[]',
		#flooring
		0=>'  ',
		#players
		1=>'{}',
		#monsters
		2=>'><'.red,
		3=>'@&'.magenta,
		#housing
		10=>'HH'.brown,
		11=>'/H'.brown,
		12=>'H\\'.brown,
		13=>'/\\'.brown,
		#trees
		20=>'tt'.green,
		#water
		30=>'wW'.blue,
		#ship
		40=>'HH'.black,
		41=>'/H'.black,
		42=>'H\\'.black,
		43=>'/\\'.black,
		44=>'()'.black,
		45=>' /'.black,
		46=>'\\ '.black,
		47=>'HH'.red,
		#walls
		100=>'  '
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

	def print_char(number,gray,color)
		out = @@CHAR_KEY[number]
		if number==100
			if color == "white"
				out = "XX".white.bg_light_gray
			end
			out = out.set_bgcolor(color)
		elsif gray
			out = out.bg_light_gray
		else
			out = out.bg_white
		end
		print out
	end

	def print_planet(number, bold)
		out = "  "
		if number > -1
			out = "()".set_color($WORLDS[number].get_color)
		end
		if bold
			print out.bg_black.bold.reverse_color
		else
			print out.bg_black
		end
	end

	def print_map(map)
		map.get_array.each do |row|
			row.each do |number|
				print_char(number,true)
			end
			puts
		end
	end

	def print_view(player)
		if player.is_onWorld
			print_view_land(player)
		else
			print_view_space(player)
		end
	end

	def print_view_land(player)
		overwrite($WINDOWSIZE,false)
		world = $WORLDS[player.get_world]
		map = player.get_map
		x0 = player.get_x
		y0 = player.get_y
		color = world.get_color
		puts "SCORE: #{$SCORE.to_s.rjust(4,"0")} MONSTERS LEFT: #{$MONSTER_COUNT.to_s.rjust(3,"0")}"
		puts "+------------------------------------------+"
		for y in (y0-5)..(y0+5)
			print "|"
			for x in (x0-10)..(x0+10)
				gray = ((y+x)%2 == 0)
				if(x<0 || x>map.get_xBound || y<0 || y>map.get_yBound)
					print_char(map.get_border,gray,color)
				elsif(x==x0 && y==y0)
					print_char(1,gray,color)
				else
					val = map.get_array[y][x]
					if val < 0
						print_char(-1,gray,color)
					else
						print_char(map.get_array[y][x],gray,color)
					end
				end
			end
			puts "|"
		end
		puts "+------------------------------------------+"
	end

	def print_view_space(player)
		world = $WORLDS[player.get_world]
		overwrite($WINDOWSIZE,false)
		puts "SCORE: #{$SCORE.to_s.rjust(4,"0")} MONSTERS LEFT: #{$MONSTER_COUNT.to_s.rjust(3,"0")}"
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

	def print_death(player)
		overwrite($WINDOWSIZE,false)
		world = $WORLDS[player.get_world]
		map = player.get_map
		x0 = player.get_x
		y0 = player.get_y
		color = world.get_color
		puts "SCORE: #{$SCORE.to_s.rjust(4,"0")} MONSTERS LEFT: #{$MONSTER_COUNT.to_s.rjust(3,"0")}"
		puts "+------------------------------------------+"
		for y in (y0-5)..(y0+5)
			print "|"
			for x in (x0-10)..(x0+10)
				if y == y0-2 && x == x0-4
					print " G A M E  O V E R ".red.bg_white
				elsif y == y0-2 && x>=x0-4 && x<=x0+4
				else
					gray = ((y+x)%2 == 0)
					if(x<0 || x>map.get_xBound || y<0 || y>map.get_yBound)
						print_char(map.get_border,gray,color)
					elsif(x==x0 && y==y0)
						print_char(2,gray,color)
					else
						val = map.get_array[y][x]
						if val < 0
							print_char(-1,gray,color)
						else
							print_char(map.get_array[y][x],gray,color)
						end
					end
				end
			end
			puts "|"
		end
		puts "+------------------------------------------+"
	end
end