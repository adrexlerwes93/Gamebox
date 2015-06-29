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

def selectWord
	words = [
		"anvil",
		"black",
		"break",
		"clear",
		"doubt",
		"exist",
		"first",
		"girth",
		"heart",
		"icons",
		"joker",
		"loath",
		"mirth",
		"notch",
		"overt",
		"print",
		"qualm",
		"react",
		"solid",
		"trick",
		"until",
		"viola",
		"water",
		"young"
	]
	return words[Random.rand(words.length)]
end

def printSimilarities(guess,word)
	(0..4).each do |i|
		print "#{guess[i].upcase} "
	end
	puts ""
	(0..4).each do |i|
		if guess[i].upcase==word[i].upcase
			print "* "
		else
			print findMatch(guess[i],word)
		end
	end
	puts ""
	print "---------  "
	$linesPrinted += 3
end

def findMatch(char,word)
	(0..4).each do |j|
		if char.upcase == word[j].upcase
			return "? "
		end
	end
	return "X "
end

def takeGuess
	guess = gets.chomp
	if guess.length == 5
		return guess
	else
		if guess.downcase == "quit"
			overwrite($linesPrinted, true)
			exit 0
		end
		puts "Word must have 5 characters"
		$linesPrinted += 2
		takeGuess
	end
end

def won(guess,word)
	if guess.upcase == word.upcase
		return true
	else
		return false
	end
end

def playAgain
	puts "Want to play again? (y/n)"
	response = gets.chomp.downcase
	if response == "y" || response == "yes"
		return true
	elsif response == "n" || response == "no"
		return false
	else
		overwrite(3,true)
		puts "Invalid input. Please respond with y or n."
		playAgain
	end
end

def playGuess
	puts "All words are 5 letters, and each letter is used only once."
	puts "  Make a guess!  "
	puts "_ _ _ _ _       (type \"quit\" to quit the game)"
	print "---------  "
	word = selectWord
	guess = ""
	guesses = 0
	$linesPrinted = 4
	while !won(guess,word)
		guess = takeGuess
		printSimilarities(guess,word)
		guesses += 1
	end
	puts ""
	puts "CORRECT! You found the word with #{guesses} guesses."
	if playAgain
		overwrite($linesPrinted+3,true)
		playGuess
	end
	overwrite($linesPrinted+3, true)
end

playGuess