class LetterMonster
	def initialize(letter, type, sound)
		@letter = letter
		@type = type
		@sound = sound
	end
	def display
		puts @letter.color_by_type(@type)
	end
	def shout
		puts sound
	end
end