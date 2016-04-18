require 'io/console'
class Input
	def initialize(val)
		case val	
		when 1
			#dir keys and return
			@up 	= 	"\e[A"
			@down 	= 	"\e[B"
			@left 	= 	"\e[D"
			@right 	= 	"\e[C"
			@enter 	= 	"\r"
		when 2
			#WASD and space
			@up 	= 	"w"
			@down 	= 	"s"
			@left 	= 	"a"
			@right 	= 	"d"
			@enter 	= 	" "
		end
	end
	def up; 	@up		end
	def down; 	@down 	end
	def right; 	@right 	end
	def left; 	@left 	end
	def enter; 	@enter 	end
	def exit;	"\u0003"end
	def debug_quit;	"~" end

	#reads user input
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
end