#TODO: Add restart game option!

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

def createGame
  board = [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0]
  (0..9).each do |i|
    (0..9).each do |j|
      board[i][j] = Random.rand(5) + 1
    end
  end
  cursor = [0,0]
  selected = []
  return [board,cursor,selected,0,20,0]
end

def printBoard(game)
  board = game[0]
  cursor = game[1]
  selected = game[2]
  puts " ------------------------------ "
  (0..9).each do |i|
    print "|"
    (0..9).each do |j|
      if cursor[0] == i && cursor[1] == j && inSelection(selected,i,j)
        print "{"
      elsif cursor[0] == i && cursor[1] == j
        print "<"
      elsif inSelection(selected,i,j)
        if game[3] == 1
          print "["
        else
          print "("
        end
      else
        print " "
      end
      case board[i][j]
      when 1
        print "@"
      when 2
        print "!"
      when 3
        print "%"
      when 4
        print "&"
      when 5
        print "#"
      end
      if cursor[0] == i && cursor[1] == j && inSelection(selected,i,j)
        print "}"
      elsif cursor[0] == i && cursor[1] == j
        print ">"
      elsif inSelection(selected,i,j)
        if game[3] == 1
          print "]"
        else
          print ")"
        end
      else
        print " "
      end
    end
    puts "|"
  end
  puts " ------------------------------ "
end

def inSelection(selected,i,j)
  selected.each do |k|
    if k[0] == i && k[1] == j
      return true
    end
  end
  return false
end

def move(game)
  selected = game[2]
  square = game[3]
  if square == 1
    moveSquare(game)
  elsif selected.size > 0
    moveSelection(game)
  else
    moveCursor(game)
  end
end

def moveSquare(game)
  board = game[0]
  cursor = game[1]
  y = cursor[0]
  x = cursor[1]
  selected = game[2]
  case read_char
  when "\e[A" 
    #up character
    if selected[-2] == [y-1,x]
      cursor = [y-1,x]
      selected = selected.take(selected.size-1)
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[B" 
    #down character
    if selected[-2] == [y+1,x]
      cursor = [y+1,x]
      selected = selected.take(selected.size-1)
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[C" 
    #right character
    if selected[-2] == [y,x+1]
      cursor = [y,x+1]
      selected = selected.take(selected.size-1)
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[D" 
    #left character
    if selected[-2] == [y,x-1]
      cursor = [y,x-1]
      selected = selected.take(selected.size-1)
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\r"
    #return key
    return deleteAndDrop(game)
  else 
    overwrite($linesPrinted, true)
    exit 0
  end
  return moveSquare(game)
end

def moveSelection(game)
  board = game[0]
  cursor = game[1]
  y = cursor[0]
  x = cursor[1]
  selected = game[2]
  case read_char
  when "\e[A" 
    #up character
    if y > 0 && board[y-1][x] == board[y][x]
      cursor = [y-1,x]
      if inSelection(selected,y-1,x)
        if selected.size > 1 && selected[-2] == cursor
          selected = selected.take(selected.size-1)
          return [board,cursor,selected,0,game[4],game[5]]
        end
        selected << cursor
        return [board,cursor,selected,1,game[4],game[5]]
      end
      selected << cursor
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[B" 
    #down character
    if y < 9 && board[y+1][x] == board[y][x]
      cursor = [y+1,x]
      if inSelection(selected,y+1,x)
        if selected.size > 1 && selected[-2] == cursor
          selected = selected.take(selected.size-1)
          return [board,cursor,selected,0,game[4],game[5]]
        end
        selected << cursor
        return [board,cursor,selected,1,game[4],game[5]]
      end
      selected << cursor
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[C" 
    #right character
    if x < 9 && board[y][x+1] == board[y][x]
      cursor = [y,x+1]
      if inSelection(selected,y,x+1)
        if selected.size > 1 && selected[-2] == cursor
          selected = selected.take(selected.size-1)
          return [board,cursor,selected,0,game[4],game[5]]
        end
        selected << cursor
        return [board,cursor,selected,1,game[4],game[5]]
      end
      selected << cursor
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[D" 
    #left character
    if x > 0 && board[y][x-1] == board[y][x]
      cursor = [y,x-1]
      if inSelection(selected,y,x-1)
        if selected.size > 1 && selected[-2] == cursor
          selected = selected.take(selected.size-1)
          return [board,cursor,selected,0,game[4],game[5]]
        end
        selected << cursor
        return [board,cursor,selected,1,game[4],game[5]]
      end
      selected << cursor
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\r"
    #return key
    if selected.size > 1
      return deleteAndDrop(game)
    end
    return [board,cursor,[],0,game[4],game[5]]
  else
    overwrite($linesPrinted, true)  
    exit 0
  end
  return moveSelection(game)
end

def moveCursor(game)
  board = game[0]
  cursor = game[1]
  selected = game[2]
  case read_char
  when "\e[A" 
    #up character
    if cursor[0] > 0
      cursor = [cursor[0]-1,cursor[1]]
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[B" 
    #down character
    if cursor[0] < 9
      cursor = [cursor[0]+1,cursor[1]]
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[C" 
    #right character
    if cursor[1] < 9
      cursor = [cursor[0],cursor[1]+1]
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\e[D" 
    #left character
    if cursor[1] > 0
      cursor = [cursor[0],cursor[1]-1]
      return [board,cursor,selected,0,game[4],game[5]]
    end
  when "\r"
    #return key
    selected << cursor
    return [board,cursor,selected,0,game[4],game[5]]
  else
    overwrite($linesPrinted, true)
    exit 0
  end
  return moveCursor(game)
end

def deleteAndDrop(game)
  if game[3] == 1
    game = removeAll(game)
  else
    game = removeSelected(game)
  end
  while hasEmpty(game)
    game = dropRow(game)
    game = fillTop(game)
  end
  game[4] = game[4] - 1
  return game
end

def removeAll(game)
  board = game[0]
  selected = game[2]
  coords = selected[0]
  y = coords[0]
  x = coords[1]
  val = board[y][x]
  count = 500
  (0..9).each do |i|
    (0..9).each do |j|
      if board[i][j] == val
        board[i][j] = 0
        count = count + 100
      end
    end
  end
  return [board,game[1],[],0,game[4],game[5]+count]
end

def removeSelected(game)
  count = 0
  game[2].each do |k|
    y = k[0]
    x = k[1]
    game[0][y][x] = 0
    count = count + 100
  end
  game[5] = game[5]+count
  return game
end

def hasEmpty(game)
  (0..9).each do |i|
    (0..9).each do |j|
      if game[0][i][j] == 0
        return true
      end
    end
  end
  return false
end

def dropRow(game)
  board = game[0]
  (0..8).each do |i|
    (0..9).each do |j|
      if board[9-i][j] == 0
        board[9-i][j] = board [8-i][j]
        board[8-i][j] = 0
      end
    end
  end
  return [board,game[1],[],0,game[4],game[5]]
end

def fillTop(game)
  (0..9).each do |j|
    if game[0][0][j] == 0
      game[0][0][j] = Random.rand(5)+1
    end
  end
  return game
end

def playDots
  $linesPrinted = 14
  game = createGame
  while game[4] != 0
    if game[4] < 10
      puts "Turns left: 0#{game[4]}"
    else
      puts "Turns left: #{game[4]}"
    end
    puts "Score: #{game[5]}"
    printBoard(game)
    game = move(game)
    overwrite($linesPrinted, false)
  end
  puts "Turns left: #{game[4]}"
  puts "Score: #{game[5]}"
  printBoard(game)
  puts "Game Over!"
  puts "Your score: #{game[5]}"
  read_char
  overwrite($linesPrinted+2,true)
  exit 0
end

playDots