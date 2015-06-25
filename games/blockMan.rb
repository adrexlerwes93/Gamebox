require 'io/console'

#reads single input from terminal
def read_char
	STDIN.echo = false
	STDIN.raw!
	input = STDIN.getc.chr
	if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!
  return input
end

#moves terminal cursor to overwrite old input
def overwrite(lines, delete)
  if delete
    lines.times do # delete one line at a time moving up n times
      system "printf \"\\033[1A\""
      system "printf \"\\033[K\""
    end
  else
    system "printf \"\\033[#{lines}A\""  # move cursor n lines up
  end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#determines initial stage based on level number
def setMap(level)
	case level
	when 1
		return [[[0,0],[1,1],[0,0],[1,0],[-1,0],[0,1],[-1,0],[0,1],[2,0],[2,0]], 3, 0, false, 8]
	when 2
		return [[[4,0],[0,0],[0,0],[0,0],[0,0],[-1,0],[-2,0],[0,0],[1,1],[0,0],[2,2],[0,0],[1,1],[0,0],[3,3]],7,0,false,0]
	when 3
		return [[[0,0],[0,0],[0,0],[1,1],[2,2],[3,3],[-3,0],[0,0],[-3,0],[-3,0],[0,0]],2,0,false,10]
	end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#prints the current stage
def printMap(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	hasBlock = stage[3]
	finish = stage[4]
	manHeight = map[location][0]
	roof = manHeight+4
	puts " --------------------------------- "
	(0..7).each do |i|
		print "|"
		(location-5..location+5).each do |j|
			if j < 0 || j > map.length-1
				print "VVV"
			elsif j == location
				height = map[j][0]
				boxes = map[j][1]
				if height >= roof-i-1
					if height == roof-i-1
						if hasBlock
							print "[ ]"
						else
							print "   "
						end
					elsif height == roof-i
						if direction == 0 #right
							if location == finish
								print "|0|"
							else
								print " 0:"
							end
						elsif direction == 1 #left
							if location == finish
								print "|0|"
							else
								print ":0 "
							end
						end
					elsif height-boxes > roof-i
						print "VVV"
					else 
						print "[ ]"
					end
				else
					print "   "
				end
			elsif j == finish
				height = map[j][0]
				boxes = map[j][1]
				if height >= roof-i
					if height == roof-i
						print "|~|"
					elsif height-boxes > roof-i
						print "VVV"
					else 
						print "[ ]"
					end
				else
					print "   "
				end			
			else
				height = map[j][0]
				boxes = map[j][1]
				if height > roof-i
					if height-boxes > roof-i
						print "VVV"
					else 
						print "[ ]"
					end
				else
					print "   "
				end
			end
		end
		puts "|"
	end
	puts " --------------------------------- "
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#determines movement based on keypress
def move(stage,level)
	case read_char
  	when "\e[C"
  		#right character  
  		if canMoveRight(stage)
  			return moveRight(stage)
  		end
  	when "\e[D"
  		#left character 
  		if canMoveLeft(stage)
  			return moveLeft(stage)
  		end
  	when "\e[A" 
		#up character
		if canClimb(stage)
			return climb(stage)
		end
	when "\e[B"
  		#down character
  		if blockPresent(stage)
  			return moveBlock(stage)
  		end
  	when "\u0003"
    	overwrite($linePrinted, true)
    	exit 0
    when "r"
    	overwrite($linePrinted, true)
   		playBlockMan(level)
   	when "s"
   		number = read_char
   		overwrite($linePrinted, true)
   		playBlockMan(number.to_i)
  	else
  		
  	end
  	move(stage,level)
end		

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#attempts to move left
def canMoveLeft(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	if direction == 0
		return true 
	elsif location > 0
		if map[location-1][0] <= map[location][0]
			return true
		end
	end
	return false
end

def moveLeft(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	hasBlock = stage[3]
	finish = stage[4]
	if direction == 0
		return [map,location,1,hasBlock,finish]
	else
		return [map,location-1,direction,hasBlock,finish]
	end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#attempts to move right
def canMoveRight(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	if direction == 1
		return true 
	elsif location < map.length-1
		if map[location+1][0] <= map[location][0]
			return true
		end
	end
	return false
end

def moveRight(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	hasBlock = stage[3]
	finish = stage[4]
	if direction == 1
		return [map,location,0,hasBlock,finish]
	else
		return [map,location+1,direction,hasBlock,finish]
	end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#attempts to move up
def canClimb(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	case direction
	when 0
		canClimbRight(stage)
	when 1
		canClimbLeft(stage)
	end
end

def canClimbRight(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	if location < map.length-1
		if map[location+1][0] == map[location][0]+1
			return true
		end
	end
	return false
end

def canClimbLeft(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	if location > 0
		if map[location-1][0] == map[location][0]+1
			return true
		end
	end
	return false
end

def climb(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	case direction
	when 0
		moveRight(stage)
	when 1
		moveLeft(stage)
	end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#attempts to lift a block
def blockPresent(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	hasBlock = stage[3]
	if hasBlock == false
		case direction
		when 0
			if location < map.length-1 && map[location+1][0] == map[location][0]+1 && map[location+1][1] > 0
				return true
			end
		when 1
			if location > 0 && map[location-1][0] == map[location][0]+1 && map[location-1][1] > 0
				return true
			end
		end
	elsif hasBlock == true
		case direction
		when 0
			if location < map.length-1 && map[location+1][0] <= map[location][0]+1
				return true
			end
		when 1
			if location > 0 && map[location-1][0] <= map[location][0]+1
				return true
			end
		end
	end
	return false
end

def moveBlock(stage)
	hasBlock = stage[3]
	case hasBlock
	when true
		return dropBlock(stage)
	when false
		return liftBlock(stage)
	end
end

def dropBlock(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	finish = stage[4]
	case direction
	when 0
		map[location+1][0] = map[location+1][0]+1
		map[location+1][1] = map[location+1][1]+1
	when 1
		map[location-1][0] = map[location-1][0]+1
		map[location-1][1] = map[location-1][1]+1
	end
	return [map,location,direction,false,finish]		
end

def liftBlock(stage)
	map = stage[0]
	location = stage[1]
	direction = stage[2]
	finish = stage[4]
	case direction
	when 0
		map[location+1][0] = map[location+1][0]-1
		map[location+1][1] = map[location+1][1]-1
	when 1
		map[location-1][0] = map[location-1][0]-1
		map[location-1][1] = map[location-1][1]-1
	end
	return [map,location,direction,true,finish]
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#asks user if they'd like to play next level
def whatNext(level)
	puts "You win! Play next level? (y/n)"
	case read_char
	when "n"
		overwrite($linePrinted, true)
		exit 0
	when "y"
		overwrite($linePrinted, true)
		playBlockMan(level+1)
	else
		overwrite(1, true)
		whatNext(level)
	end
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#run game
def playBlockMan(level)
	maxLevel = 3
	$linePrinted = 11
	while level <= maxLevel
		stage = setMap(level)
		while stage[1] != stage[4]
			printMap(stage)
			puts "(ctr-c) to quit"
			stage = move(stage,level)
			overwrite($linePrinted,false)
		end
		printMap(stage)
		whatNext(level)
	end
	puts "\nYou've completed the game!!!!!\n You're a true Block Man master!"
	read_char
	overwrite(3,true)
	exit 0
end

playBlockMan(1)