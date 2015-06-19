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
def overwrite(lines)
  count = 0
  while count < lines
    count += 1
    system "printf \"\\033[1A\"  # move cursor one line up"
    #system "printf \"\\033[K\"   # delete till end of line"
  end
end

def menu(int)
  linesPrinted = 10
  totalOptions = 7
  #puts ".....  .....  .   .  ....."
  #puts ".      .   .  .. ..  .    "
  #puts ".  ..  .....  . . .  ...  "
  #puts ".   .  .   .  .   .  .    "
  #puts ".....  .   .  .   .  ....."
  #puts "   ....    ...   .   ."
  #puts "   .   .  .   .   . . "
  #puts "   ....   .   .    .  "
  #puts "   .   .  .   .   . . "
  #puts "   ....    ...   .   ."
  puts "~~GAMEBOX~~"
  puts ""
  case int
  when 1
    puts "* Play 2048"
    puts "  Play Dots"
    puts "  Play Block Man"
    puts "  Play PEGS"
    puts "  Play TicTacToe"
    puts "  Play Guess The Word"
    puts "\n  Quit"
  when 2
    puts "  Play 2048"
    puts "* Play Dots"
    puts "  Play Block Man"
    puts "  Play PEGS"
    puts "  Play TicTacToe"
    puts "  Play Guess The Word"
    puts "\n  Quit"
  when 3
    puts "  Play 2048"
    puts "  Play Dots"
    puts "* Play Block Man"
    puts "  Play PEGS"
    puts "  Play TicTacToe"
    puts "  Play Guess The Word"
    puts "\n  Quit"
  when 4
    puts "  Play 2048"
    puts "  Play Dots"
    puts "  Play Block Man"
    puts "* Play PEGS"
    puts "  Play TicTacToe"
    puts "  Play Guess The Word"
    puts "\n  Quit"
  when 5
    puts "  Play 2048"
    puts "  Play Dots"
    puts "  Play Block Man"
    puts "  Play PEGS"
    puts "* Play TicTacToe"
    puts "  Play Guess The Word"
    puts "\n  Quit"
  when 6
    puts "  Play 2048"
    puts "  Play Dots"
    puts "  Play Block Man"
    puts "  Play PEGS"
    puts "  Play TicTacToe"
    puts "* Play Guess The Word"

    puts "\n  Quit"
  when 0
    puts "  Play 2048"
    puts "  Play Dots"
    puts "  Play Block Man"
    puts "  Play PEGS"
    puts "  Play TicTacToe"
    puts "  Play Guess The Word"
    puts "\n* Quit"
  end
  input = read_char
  overwrite(linesPrinted)
  case input
  when "\e[C" #right character
    menu((int+1)%totalOptions)
  when "\e[B" #down character
    menu((int+1)%totalOptions)
  when "\e[D" #left character
    menu((int-1)%totalOptions)
  when "\e[A" #up character
    menu((int-1)%totalOptions)
  when "\r"
    case int
    when 1
      system "ruby games/2048.rb"
      menu(1)
    when 2
      system "ruby games/dots.rb"
      menu(2)
    when 3
      system "ruby games/blockMan.rb"
      menu(3)
    when 4
      system "ruby games/pegs.rb"
      menu(4)
    when 5
      system "ruby games/TicTacToe.rb"
      menu(5)
    when 6
      system "ruby games/guessTheWord.rb"
      menu(6)
    when 0
      system "clear"
      exit 0
    end
  when "\u0003"
    system "clear"
    exit 0
  else
    menu(int)
  end
end
#puts "\n\n\n\n\n\n\n\n\n\n" #10 times
menu(1)

