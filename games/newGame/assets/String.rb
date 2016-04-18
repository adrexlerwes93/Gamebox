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
	def yellow;			"\e[93m#{self}\e[0m" end
	def white;			"\e[97m#{self}\e[0m" end

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
	def bg_gray;		"\e[100m#{self}\e[0m"end
	def bg_yellow;		"\e[103m#{self}\e[0m"end
	def bg_white;		"\e[107m#{self}\e[0m"end

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