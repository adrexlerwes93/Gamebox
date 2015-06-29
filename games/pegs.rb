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
    lines.times do
      system "printf \"\\033[1A\""
      system "printf \"\\033[K\""
    end
  else
    system "printf \"\\033[#{lines}A\""  # move cursor n lines up
  end
end

def createBoard(level)
	case level #select the board for the current level
	when 1 #13
		return [[0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,2,0,0],
				[0,0,0,0,0,0,3,0,0],
				[0,0,0,0,1,0,4,0,0],
				[0,4,0,0,0,0,0,0,0],
				[0,3,0,0,0,0,0,0,0],
				[0,2,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0]]
	when 2 #13
		return [[0,1,0],
				[2,3,4],
				[0,0,0],
				[2,0,3],
				[0,0,0],
				[3,3,2],
				[0,0,0],
				[3,3,2],
				[0,0,4]]
	when 3 #8
		return [[1,0,2,2],
				[2,3,4,4],
				[4,3,3,4],
				[2,2,2,3]]
	when 4 #10
		return [[0,0,0,0,0,0,2],
				[0,0,3,4,4,0,0],
				[2,0,4,4,3,0,0],
				[2,0,0,2,0,0,3],
				[0,0,0,3,0,0,0],
				[0,3,3,1,3,3,0]]
	when 5 #8
		return [[4,4,0,0,3,0,0,0,0,3,4,4,2,0,4],
				[2,1,0,0,0,2,0,4,0,0,0,0,0,0,0],
				[3,0,0,0,0,0,0,3,0,2,2,4,2,3,0],
				[2,0,0,0,0,0,4,3,0,0,0,0,2,0,0]]
	end
end

def printBoard(board)
	print " "
	board[0].length.times do
		print "--"
	end
	puts " "
	(0..board.length-1).each do |i|
		print "|"
		(0..board[0].length-1).each do |j|
			square = board[i][j]
			case square
			when 1 #player
				print "{}"
			when 2 #X
				print "><"
			when 3 #square
				print "<>"
			when 4 #circle
				print "()"
			else
				print "  "
			end
		end
		puts "|"
	end
	print " "
	board[0].length.times do
		print "--"
	end	
	puts " "
end

def nextSpaceUp(board,i,j)
	return board[i-1][j]
end

def nextSpaceDown(board,i,j)
	return board[i+1][j]
end

def nextSpaceLeft(board,i,j)
	return board[i][j-1]
end

def nextSpaceRight(board,i,j)
	return board[i][j+1]
end

def move(board,level)
	case read_char
	when "\e[A" 
		#up character
    	moveUp(board)
  	when "\e[B"
  		#down character
  		moveDown(board)
  	when "\e[C"
  		#right character
  		moveRight(board)
  	when "\e[D"
  		#left character
  		moveLeft(board)
    when "\u0003"
    	overwrite($linesPrinted, true)
    	exit 0
    when "r"
   		playPegs(level)
   	when "s"
   		number = read_char
   		overwrite($linesPrinted, true)
   		playPegs(number.to_i)
    else 
    	move(board,level)
    end
end

def moveUp(board)
	(0..board.length-1).each do |i|
		(0..board[0].length-1).each do |j|
			if board[i][j] == 1
				if i != 0
					if board[i-1][j] == 0 #empty space
						board[i-1][j] = 1
						board[i][j] = 0
					elsif i != 1 
						if board[i-2][j] == board[i-1][j]
							board[i-2][j] = 0
							board[i-1][j] = 1
							board[i][j] = 0
						elsif board[i-2][j] == 0
							board[i-2][j] = board[i-1][j]
							board[i-1][j] = 1
							board[i][j] = 0
						else
							lose(board)
						end
					end
				end
				return board
			end
		end
	end	
end

def moveDown(board)
	(0..board.length-1).each do |i|
		(0..board[0].length-1).each do |j|
			if board[i][j] == 1
				if i != board.length-1
					if board[i+1][j] == 0 #empty space
						board[i+1][j] = 1
						board[i][j] = 0
					elsif i != board.length-2 
						if board[i+2][j] == board[i+1][j]
							board[i+2][j] = 0
							board[i+1][j] = 1
							board[i][j] = 0
						elsif board[i+2][j] == 0
							board[i+2][j] = board[i+1][j]
							board[i+1][j] = 1
							board[i][j] = 0
						else
							lose(board)
						end
					end
				end
				return board
			end
		end
	end	
end

def moveLeft(board)
	(0..board.length-1).each do |i|
		(0..board[0].length-1).each do |j|
			if board[i][j] == 1
				if j != 0
					if board[i][j-1] == 0 #empty space
						board[i][j-1] = 1
						board[i][j] = 0
					elsif j != 1 
						if board[i][j-2] == board[i][j-1]
							board[i][j-2] = 0
							board[i][j-1] = 1
							board[i][j] = 0
						elsif board[i][j-2] == 0
							board[i][j-2] = board[i][j-1]
							board[i][j-1] = 1
							board[i][j] = 0
						else
							lose(board)
						end
					end
				end
				return board
			end
		end
	end	
end

def moveRight(board)
	(0..board.length-1).each do |i|
		(0..board[0].length-1).each do |j|
			if board[i][j] == 1
				if j != board[0].length-1
					if board[i][j+1] == 0 #empty space
						board[i][j+1] = 1
						board[i][j] = 0
					elsif j != board[0].length-2 
						if board[i][j+2] == board[i][j+1]
							board[i][j+2] = 0
							board[i][j+1] = 1
							board[i][j] = 0
						elsif board[i][j+2] == 0
							board[i][j+2] = board[i][j+1]
							board[i][j+1] = 1
							board[i][j] = 0
						else
							lose(board)
						end
					end
				end
				return board
			end
		end
	end	
end

def lose(board)
	board[0][0] = "l"
	board[1][0] = "You Lose! Restart? (y/n)"
end

def win?(board)
	def winner?(board)
		(0..board.length-1).each do |i|
			(0..board[0].length-1).each do |j|
				if board[i][j] != 0 && board[i][j] != 1
					return false
				end
			end
		end
		return true
	end
	if winner?(board)
		board[0][0] = "w"
		board[1][0] = "You win! Play next level? (y/n)"
	end
end

def whatNext(state,level)
	case read_char
	when "n"
		overwrite($linesPrinted, true)
		exit 0
	when "y"
		overwrite($linesPrinted, true)
		if state == "w"
			playPegs(level+1)
		elsif state == "l"
			playPegs(level)
		end
	else
		overwrite(1,true)
		whatNext(state,level)
	end
end

def playPegs(level)
	maxLevel = 5
	$linesPrinted = 0
	while level <= maxLevel
		board = createBoard(level)
		$linesPrinted = board.length + 4
		while board[0][0] != "w" && board[0][0] != "l"
			puts "Level #{level}"
			printBoard(board)
			puts "(ctr-c) to quit"
			move(board,level)
			win?(board)
			overwrite($linesPrinted,false)
		end
		puts "Level #{level}"
		printBoard(board)
		puts board[1][0]
		whatNext(board[0][0],level)
	end
	puts "\nYou've completed the game!!!!!\n You're a true PEGS master!"
	read_char
	overwrite(3,true)
	exit 0
end

playPegs(1)