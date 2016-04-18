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

#prints out the current board
def printBoard(board)
	linebreak = " --- --- --- --- --- --- --- --- --- ---"
	puts linebreak
	(0..9).each do |row|
		(0..9).each do |col|
			space = board[row][col]
			if space == 0
				print "|   "
			elsif space == 1
				print "|[8]"
			end
		end
		puts "|"
		puts linebreak
	end
end

board = 
[[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0]]

printBoard(board)



# --- --- --- --- --- --- --- --- --- --- 
#|{8}|   |   |   |   |   |   |   |   |   |
# --- --- --- --- --- --- --- --- --- ---  [][][][][]
#|   |   |   |   |   |   |   |   |   |   | []
# --- --- --- --- --- --- --- --- --- ---  []
#|( )|( )|( )|   |   |   |   |   |   |   | []
# --- --- --- --- --- --- --- --- --- ---  []
#|   |   |   |   |   |   |   |   |   |   | 
# --- --- --- --- --- --- --- --- --- ---  [][][][][]
#|   |   |   |   |   |   |   |   |   |   | []
# --- --- --- --- --- --- --- --- --- ---  []
#|   |   |   |   |   |   |   |   |   |   | []
# --- --- --- --- --- --- --- --- --- ---  []
#|   |   |   |   |   |   |   |   |   |   | 
# --- --- --- --- --- --- --- --- --- ---  [][][][][]
#|   |   |   |   |   |   |   |   |   |   | []
# --- --- --- --- --- --- --- --- --- ---  []
#|   |   |   |   |   |   |   |   |   |   | []
# --- --- --- --- --- --- --- --- --- ---  []
#|   |   |   |   |   |   |   |   |   |   | 
# --- --- --- --- --- --- --- --- --- ---

