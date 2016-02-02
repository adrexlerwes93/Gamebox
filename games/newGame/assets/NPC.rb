class NPC
	def initialize(speech,letters)
		@speech = speech
		@letters = letters
	end
	def talk
		puts @speech
	end
	def add_letters(letters)
		@letters.push(letters)
	end
	def get_letters
		return @letters
	end
	def say_letters
		@letters.each do |letter|
			letter.display
		end
	end
end