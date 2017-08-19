require 'io/console'

class String
  $STRING_COLORS=10
  $BACKGROUND_COLORS=8
  ##http://misc.flogisoft.com/bash/tip_colors_and_formatting
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end
  def yellow;     "\e[93m#{self}\e[0m" end
  def white;      "\e[97m#{self}\e[0m" end

  def set_color(color)
    case color
    when "black"
      "\e[30m#{self}\e[0m"
    when "red"
      "\e[31m#{self}\e[0m"
    when "green"
      "\e[32m#{self}\e[0m"
    when "brown"
      "\e[33m#{self}\e[0m"
    when "blue"
      "\e[34m#{self}\e[0m"
    when "magenta"
      "\e[35m#{self}\e[0m"
    when "cyan"
      "\e[36m#{self}\e[0m"
    when "gray"
      "\e[37m#{self}\e[0m"
    when "yellow"
      "\e[93m#{self}\e[0m"
    when "white"
      "\e[97m#{self}\e[0m"
    end
  end

  #colorize background
  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_light_gray;  "\e[47m#{self}\e[0m" end
  def bg_gray;    "\e[100m#{self}\e[0m"end
  def bg_yellow;    "\e[103m#{self}\e[0m"end
  def bg_white;   "\e[107m#{self}\e[0m"end

  def set_bgcolor(color)
    case color
    when "black"
      "\e[40m#{self}\e[0m"
    when "red"
      "\e[41m#{self}\e[0m"
    when "green"
      "\e[42m#{self}\e[0m"
    when "brown"
      "\e[43m#{self}\e[0m"
    when "blue"
      "\e[44m#{self}\e[0m"
    when "magenta"
      "\e[45m#{self}\e[0m"
    when "cyan"
      "\e[46m#{self}\e[0m"
    when "light gray"
      "\e[47m#{self}\e[0m"
    when "gray"
      "\e[100m#{self}\e[0m"
    when "yellow"
      "\e[103m#{self}\e[0m"
    when "white"
      "\e[107m#{self}\e[0m"
    end
  end
  #stylize text
  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

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

#Creates game object
#game[0] = board
#game[1] = cursor location
#game[2] = list of selected symbols
#game[3] =
#game[4] = turns left
#game[5] = score
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
      board[i][j] = Random.rand(6) + 1
    end
  end
  cursor = [0,0]
  selected = []
  return [board,cursor,selected,0,20,0]
end

def printChar(char, color)
  char = char
  case color
  when 'GRAY'
    print char.black.bg_light_gray
  when 'GREEN'
    print char.yellow.bg_green
  when 'YELLOW'
    print char.green.bg_yellow
  when 'CYAN'
    print char.magenta.bg_cyan
  when 'MAGENTA'
    print char.cyan.bg_magenta
  when 'BLACK'
    print char.white.bg_black
  else
    print char
  end
end

def printBoard(game)
  board = game[0]
  cursor = game[1]
  selected = game[2]
  puts " ------------------------------ "
  (0..9).each do |i|
    print "|"
    (0..9).each do |j|
      case board[i][j]
      when 1
        char = "@"
        color = 'GRAY'
      when 2
        char = "!"
        color = 'GREEN'
      when 3
        char = "%"
        color = 'YELLOW'
      when 4
        char = "&"
        color = 'CYAN'
      when 5
        char = "#"
        color = 'MAGENTA'
      when 6
        char = "~"
        color = "BLACK"
      end
      if cursor[0] == i && cursor[1] == j && inSelection(selected,i,j)
        printChar("{", color)
      elsif cursor[0] == i && cursor[1] == j
        printChar("<", color)
      elsif inSelection(selected,i,j)
        if game[3] == 1
          printChar("[", color)
        else
          printChar("(", color)
        end
      else
        printChar(" ", color)
      end
      printChar(char, color)
      if cursor[0] == i && cursor[1] == j && inSelection(selected,i,j)
        printChar("}", color)
      elsif cursor[0] == i && cursor[1] == j
        printChar(">", color)
      elsif inSelection(selected,i,j)
        if game[3] == 1
          printChar("]", color)
        else
          printChar(")", color)
        end
      else
        printChar(" ", color)
      end
    end
    puts "|"
  end
  puts " ------------------------------ "
end

#Determines if symbol at (i,j) has already been selected.
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

#Takes input when a square has been formed in selection.
# Can only move back to previous selection or remove.
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
  when " "
    #Oren's return key
    return deleteAndDrop(game)
  else 
    overwrite($linesPrinted, true)
    exit 0
  end
  return moveSquare(game)
end

#Move cursor and update selection if selection is currently being made
# but no square has been made.
# Can move in any direction that has the same symbol as current selection or delete.
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
  when " "
    #Oren's return key
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

#Movement when no selection has been made. 
# Can move in any direction but can't delete, only select.
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
  when " "
    #Oren's return key
    selected << cursor
    return [board,cursor,selected,0,game[4],game[5]]
  else
    overwrite($linesPrinted, true)
    exit 0
  end
  return moveCursor(game)
end

#Determines which symbols to delete, then shifts all remaining symbols down.
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

#Removes all of a type of symbol from the board.
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

#Removes only selected symbols from board.
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

#Determines if the board has an empty space.
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

#Slides all symbols down as far as possible.
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

#Fills empty spaces at top of board with new symbols.
def fillTop(game)
  (0..9).each do |j|
    if game[0][0][j] == 0
      game[0][0][j] = Random.rand(6)+1
    end
  end
  return game
end

#provides option to start over after a loss
def playAgain
  puts "Want to play again? (y/n)"
  response = gets.chomp.downcase
  overwrite(2,true)
  if response == "y" || response == "yes"
    return true
  elsif response == "n" || response == "no"
    return false
  else
    overwrite(1,true)
    puts "Invalid input. Please respond with y or n."
    playAgain
  end
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
  if playAgain
    overwrite($linesPrinted+2,true)
    playDots
  else
    overwrite($linesPrinted+2,true)
    exit 0
  end
end

playDots