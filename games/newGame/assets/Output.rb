class Output

	$WINDOWSIZE=13

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

	def print_map(map)
		map.get_array.each do |row|
			row.each do |number|
				print_char(number)
			end
			puts
		end
	end

	def print_view(map,x0,y0)
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
end