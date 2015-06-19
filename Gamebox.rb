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

def menu(int)
  system "clear"
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
  case read_char
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
      system "ruby 2048.rb"
      menu(1)
    when 2
      system "ruby dots.rb"
      menu(2)
    when 3
      system "ruby blockMan.rb"
      menu(3)
    when 4
      system "ruby pegs.rb"
      menu(4)
    when 5
      system "ruby TicTacToe.rb"
      menu(5)
    when 6
      system "ruby guessTheWord.rb"
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

menu(1)

