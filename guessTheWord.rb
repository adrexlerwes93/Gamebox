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
			system "clear"
			exit 0
		end
		puts "Word must have 5 characters"
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
		puts "Invalid input. Please respond with y or n."
		playAgain
	end
end

def playGuess
	system "clear"
	puts "\n All words are 5 letters, and each letter is used only once."
	puts "  Make a guess!  "
	puts "_ _ _ _ _       (type \"quit\" to quit the game)"
	print "---------  "
	word = selectWord
	guess = ""
	guesses = 0
	while !won(guess,word)
		guess = takeGuess
		printSimilarities(guess,word)
		guesses = guesses + 1
	end
	puts ""
	puts "CORRECT! You found the word with #{guesses} guesses."
	if playAgain
		playGuess
	end
	system "clear"
end

playGuess