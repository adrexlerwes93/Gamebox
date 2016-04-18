require 'io/console'

gamesDir = Dir["games/*"]
$games = []
gamesDir.each do |gameFile|
  $games << File.basename(gameFile,".rb")
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

def menuTest
  int = 0
  totalOptions = $games.length + 1 #all games plus quit
  $linesPrinted = totalOptions + 3 #2 lines for header and 1 for space before quit
  while true
    #Print menu
    puts "~~GAMEBOX~~"
    puts
    $games.each_with_index do |game,index|
      if int == index then print "*" else print " " end
      puts " Play #{game}"
    end
    puts
    if int == totalOptions - 1 then print "*" else print " " end
    puts " Quit"

    #Get input
    case read_char
    when "\e[C" #right character
      overwrite($linesPrinted, false)
      int = (int+1)%totalOptions
    when "\e[B" #down character
      overwrite($linesPrinted, false)
      int = (int+1)%totalOptions
    when "\e[D" #left character
      overwrite($linesPrinted, false)
      int = (int-1)%totalOptions
    when "\e[A" #up character
      overwrite($linesPrinted, false)
      int = (int-1)%totalOptions
    when "\r"
      overwrite($linesPrinted, true)
      if int == totalOptions - 1
        exit 0
      else
        system "cd games && ruby #{$games[int]}.rb"
      end
    when "\u0003"
    overwrite($linesPrinted, true)
    exit 0
    else
      overwrite($linesPrinted, false)
    end
  end
end

menuTest

