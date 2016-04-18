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

def newGame
  game = Hash["board" => [[-1,0,0],[0,0,0],[0,0,0]], "player" => 1]
  return game
end

def printBoard(game)
  (0..2).each do |i|
    print "  "
    (0..2).each do |j|
      case game["board"][i][j]
      when -1
        print " * "
      when 0
        print "   "
      when 1
        print " X "
      when 2
        print " O "
      end
      if j == 2
        puts ""
      else print "|"
      end
    end
    if i == 2
      puts ""
    else 
      puts "  ---+---+---"
    end
  end
end

def move(game)
  case read_char
  when "\e[A" 
    #up character
    moveUp(game)  
  when "\e[B"
    #down character
    moveDown(game)
  when "\e[C"
    #right character
    moveRight(game)
  when "\e[D"
    #left character
    moveLeft(game)
  when "\r"
    place(game)
  when "\u0003"
    overwrite($linesPrinted,true)
    exit 0
  else move(game)
  end
end

def moveUp(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == -1
        game["board"][i][j] = 0
        row = i-1
        column = j
        while row != i || column != j
          if row < 0
            row = 2
            column = column-1
            if column < 0
              column = 2
            end
          end
          if game["board"][row][column] == 0
            game["board"][row][column] = -1
            return game
          end
          row = row-1
        end
      end
    end
  end
end

def moveDown(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == -1
        game["board"][i][j] = 0
        row = i+1
        column = j
        while row != i || column != j
          if row > 2
            row = 0
            column = column+1
            if column > 2
              column = 0
            end
          end
          if game["board"][row][column] == 0
            game["board"][row][column] = -1
            return game
          end
          row = row+1
        end
      end
    end
  end
end

def moveRight(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == -1
        game["board"][i][j] = 0
        row = i
        column = j+1
        while row != i || column != j
          if column > 2
            column = 0
            row = row+1
            if row > 2
              row = 0
            end
          end
          if game["board"][row][column] == 0
            game["board"][row][column] = -1
            return game
          end
          column = column+1
        end
      end
    end
  end
end

def moveLeft(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == -1
        game["board"][i][j] = 0
        row = i
        column = j-1
        while row != i || column != j
          if column < 0
            column = 2
            row = row-1
            if row < 0
              row = 2
            end
          end
          if game["board"][row][column] == 0
            game["board"][row][column] = -1
            return game
          end
          column = column-1
        end
      end
    end
  end
end

def place(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == -1
        game["board"][i][j] = game["player"]
        game["player"] = (game["player"]%2)+1
        return newCursor(game)
      end
    end
  end
end

def newCursor(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == 0
        game["board"][i][j] = -1
        return game
      end
    end
  end
end

def winner(game)
  b = game["board"]
  if b[1][1] != 0 && (((b[0][0] == b[1][1]) && (b[1][1] == b[2][2])) || ((b[0][2] == b[1][1]) && (b[1][1] == b[2][0])))
    return true
  else
    (0..2).each do |i|
      if b[i][0] != 0 && ((b[i][0] == b[i][1]) && (b[i][1] == b[i][2]))
        return true
      elsif b[0][i] != 0 && ((b[0][i] == b[1][i]) && (b[1][i] == b[2][i]))
        return true
      end
    end
  end
  return false
end

def spacesUsed(game)
  (0..2).each do |i|
    (0..2).each do |j|
      if game["board"][i][j] == -1
        return false
      end
    end
  end
  return true
end

def whatNext
  puts "Want to play again? (y/n)"
  case read_char
  when "n"
    overwrite($linesPrinted,true)
    exit 0
  when "y"
    overwrite($linesPrinted,true)
    playTicTacToe
  else
    overwrite(1,true)
    whatNext
  end
end

def playTicTacToe
  $linesPrinted = 8
  game = newGame
  while !winner(game) & !spacesUsed(game)
    puts "Player #{game["player"]}'s turn!"
    printBoard(game)
    puts "(ctr-c) to quit"
    move(game)
    overwrite($linesPrinted-1,false)
    overwrite(1,true)
  end
  if winner(game)
    winnerNumber = (game["player"]%2)+1
    puts "Player #{winnerNumber} wins!"
  elsif spacesUsed(game)
    puts "   Cat game!"
  end
  printBoard(game)
  whatNext
end

playTicTacToe

