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

def menu(int)
  $linesPrinted = 10
  totalOptions = 7
  puts "~~GAMEBOX~~"
  puts ""
  if int==1 then print "*" else print " " end            
  puts " Play 2048"
  if int==2 then print "*" else print " " end
  puts " Play Dots"
  if int==3 then print "*" else print " " end 
  puts " Play Block Man"
  if int==4 then print "*" else print " " end
  puts " Play PEGS"
  if int==5 then print "*" else print " " end 
  puts " Play TicTacToe"
  if int==6 then print "*" else print " " end
  puts " Play Guess The Word"
  puts ""
  if int==0 then print "*" else print " " end
  puts " Quit"

  case read_char
  when "\e[C" #right character
    overwrite($linesPrinted, false)
    menu((int+1)%totalOptions)
  when "\e[B" #down character
    overwrite($linesPrinted, false)
    menu((int+1)%totalOptions)
  when "\e[D" #left character
    overwrite($linesPrinted, false)
    menu((int-1)%totalOptions)
  when "\e[A" #up character
    overwrite($linesPrinted, false)
    menu((int-1)%totalOptions)
  when "\r"
    overwrite($linesPrinted, true)
    case int
    when 1
      system "ruby games/2048.rb"
    when 2
      system "ruby games/dots.rb"
    when 3
      system "ruby games/blockMan.rb"
    when 4
      system "ruby games/pegs.rb"
    when 5
      system "ruby games/TicTacToe.rb"
    when 6
      system "ruby games/guessTheWord.rb"
    when 0
      #system "clear"
      exit 0
    end
  when "\u0003"
    overwrite($linesPrinted, true)#system "clear"
    exit 0
  end
  menu(int)
end
#puts "\n\n\n\n\n\n\n\n\n\n" #10 times
menu(1)

