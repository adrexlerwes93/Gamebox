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

#create the initual 4X4 board with all zeros
def createBoard
	board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
	return addVal(addVal(board))
end

#prints out the current board
def printBoard(board)
	#creates individual square
	def makeSquare(value)
		if value == 0
			return "|     "
		elsif value == 2048
			return "|2048!"
		else
			halfSpaces = (5.0 - value.to_s.length)/2.0
			frontSpaces = halfSpaces.ceil
			backSpaces = halfSpaces.floor
			square = "|"
			frontSpaces.times do
				square << " "
			end
			square << value.to_s
			backSpaces.times do
				square << " "
			end
			return square
		end
	end
	lineBreak = " ----- ----- ----- ----- "
	puts lineBreak
	(0..3).each do |i|
		(0..3).each do |j|
			print makeSquare(board[i][j])
		end
		puts "|"
		puts lineBreak
	end
end

#returns a board with added value
def addVal(board)
	#returns a 2 or a 4 randomly
	def twoOrFour()
		if Random.rand(4) == 1
			return 4
		else 
			return 2
		end
	end
	i = Random.rand(4)
	j = Random.rand(4)
	if board[i][j] == 0
		board[i][j] = twoOrFour()
		return board
	else 
		addVal(board)
	end
end

##########################################

#returns false when no moves can be made
def playable(board)
	if canSlideUp(board) || canSlideDown(board) || canSlideRight(board) || canSlideLeft(board)
		return true
	else
		return false
	end
end

#determines if up move is possible
def canSlideUp(board)
	(0..3).each do |i|
		hasZero = false
		lastInt = 0
		(0..3).each do |j|
			if board[j][i] == 0
				hasZero = true
			elsif hasZero
				return true
			elsif board[j][i] == lastInt
				return true
			else
				lastInt = board[j][i]
			end
		end
	end
	return false
end

#determines if down move is possible
def canSlideDown(board)
	(0..3).each do |i|
		hasZero = false
		lastInt = 0
		(0..3).each do |j|
			if board[3-j][i] == 0
				hasZero = true
			elsif hasZero
				return true
			elsif board[3-j][i] == lastInt
				return true
			else
				lastInt = board[3-j][i]
			end
		end
	end
	return false
end

#determines if right move is possible
def canSlideRight(board)
	(0..3).each do |i|
		hasZero = false
		lastInt = 0
		(0..3).each do |j|
			if board[i][3-j] == 0
				hasZero = true
			elsif hasZero
				return true
			elsif board[i][3-j] == lastInt
				return true
			else
				lastInt = board[i][3-j]
			end
		end
	end
	return false
end

#determines if left move is possible
def canSlideLeft(board)
	(0..3).each do |i|
		hasZero = false
		lastInt = 0
		(0..3).each do |j|
			if board[i][j] == 0
				hasZero = true
			elsif hasZero
				return true
			elsif board[i][j] == lastInt
				return true
			else
				lastInt = board[i][j]
			end
		end
	end
	return false
end

##########################################

#moves squares and does addition based on direction selected
def slide(board)
	case read_char
	when "\e[A" 
		#up character
    	if canSlideUp(board)
    		slideUp(addUp(slideUp(board)))
    	else slide(board)
    	end
  	when "\e[B"
  		#down character
  		if canSlideDown(board)
    		slideDown(addDown(slideDown(board)))
    	else slide(board)
    	end
  	when "\e[C"
  		#right character
  		if canSlideRight(board)
    		slideRight(addRight(slideRight(board)))
    	else slide(board)
    	end
  	when "\e[D"
  		#left character
  		if canSlideLeft(board)
    		slideLeft(addLeft(slideLeft(board)))
    	else slide(board)
    	end
    when "\u0003"
    	system "clear"
    	exit 0
    else slide(board)
    end
end

##########################################

#slide all squares up
def slideUp(board)
	(0..3).each do |i|
		(0..3).each do |j|
			if board[j][i] == 0
				foundNum = false
				(j..3).each do |k|
					if board[k][i] != 0 && foundNum == false
						board[j][i] = board[k][i]
						board[k][i] = 0
						foundNum = true
					end
				end
			end
		end
	end
	return board
end

#slide all squares down
def slideDown(board)
	(0..3).each do |i|
		(0..3).each do |j|
			if board[3-j][i] == 0
				foundNum = false
				(j..3).each do |k|
					if board[3-k][i] != 0 && foundNum == false
						board[3-j][i] = board[3-k][i]
						board[3-k][i] = 0
						foundNum = true
					end
				end
			end
		end
	end
	return board
end

#slide all squares right
def slideRight(board)
	(0..3).each do |i|
		(0..3).each do |j|
			if board[i][3-j] == 0
				foundNum = false
				(j..3).each do |k|
					if board[i][3-k] != 0 && foundNum == false
						board[i][3-j] = board[i][3-k]
						board[i][3-k] = 0
						foundNum = true
					end
				end
			end
		end
	end
	return board
end

#slide all squares left
def slideLeft(board)
	(0..3).each do |i|
		(0..3).each do |j|
			if board[i][j] == 0
				foundNum = false
				(j..3).each do |k|
					if board[i][k] != 0 && foundNum == false
						board[i][j] = board[i][k]
						board[i][k] = 0
						foundNum = true
					end
				end
			end
		end
	end
	return board
end

##########################################

#add equivalent common squares in up direction
def addUp(board)
	(0..3).each do |i|
		lastInt = 0
		(0..3).each do |j|
			if board[j][i] != 0 && board[j][i] == lastInt
				board[j-1][i] = 2*board[j][i]
				board[j][i] = 0
				lastInt = 0
			else
				lastInt = board[j][i]
			end
		end
	end
	return board
end

#add equivalent common squares in down direction
def addDown(board)
	(0..3).each do |i|
		lastInt = 0
		(0..3).each do |j|
			if board[3-j][i] != 0 && board[3-j][i] == lastInt
				board[4-j][i] = 2*board[3-j][i]
				board[3-j][i] = 0
				lastInt = 0
			else
				lastInt = board[3-j][i]
			end
		end
	end
	return board
end

#add equivalent common squares in right direction
def addRight(board)
	(0..3).each do |i|
		lastInt = 0
		(0..3).each do |j|
			if board[i][3-j] != 0 && board[i][3-j] == lastInt
				board[i][4-j] = 2*board[i][3-j]
				board[i][3-j] = 0
				lastInt = 0
			else
				lastInt = board[i][3-j]
			end
		end
	end
	return board
end

#add equivalent common squares in left direction
def addLeft(board)
	(0..3).each do |i|
		lastInt = 0
		(0..3).each do |j|
			if board[i][j] != 0 && board[i][j] == lastInt
				board[i][j-1] = 2*board[i][j]
				board[i][j] = 0
				lastInt = 0
			else
				lastInt = board[i][j]
			end
		end
	end
	return board
end

##########################################

#provides option to start over after a loss
def playAgain
	puts "Want to play again? (y/n)"
	response = gets.chomp.downcase
	if response == "y" || response == "yes"
		return true
	elsif response == "n" || response == "no"
		return false
	else
		puts "Invalid input. Please respond with y or n."
		playAgain
	end
end

def winner?(board)
	max = 2048
	hasWinner = false
	(0..3).each do |i|
		(0..3).each do |j|
			if board[i][j] >= 2048
				hasWinner = true
				if board[i][j] >= max
					max = board[i][j]
				end
			end
		end
	end
	if hasWinner
		puts "CONGRATULATIONS! YOU'VE REACHED #{max}!!"
	end
end


#runs the game
def play2048
	system "clear"
	board = createBoard
	while playable(board)
		printBoard(board)
		puts "(ctr-c) to quit"
		winner?(board)
		slide(board)
		addVal(board)
		system "clear"
	end
	printBoard(board)
	puts "YOU LOSE!"
	if playAgain
		play2048
	end
	system "clear"
end

##########################################

#runs on start
play2048

##########################################

=begin
# Reads keypresses from the user including 2 and 3 escape character sequences.
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

# oringal case statement from:
# http://www.alecjacobson.com/weblog/?p=75
def show_single_key
  c = read_char

  case c
  when " "
    puts "SPACE"
  when "\t"
    puts "TAB"
  when "\r"
    puts "RETURN"
  when "\n"
    puts "LINE FEED"
  when "\e"
    puts "ESCAPE"
  when "\e[A"
    puts "UP ARROW"
  when "\e[B"
    puts "DOWN ARROW"
  when "\e[C"
    puts "RIGHT ARROW"
  when "\e[D"
    puts "LEFT ARROW"
  when "\177"
    puts "BACKSPACE"
  when "\004"
    puts "DELETE"
  when "\e[3~"
    puts "ALTERNATE DELETE"
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  when /^.$/
    puts "SINGLE CHAR HIT: #{c.inspect}"
  else
    puts "SOMETHING ELSE: #{c.inspect}"
  end
end

show_single_key while(true)
=end


