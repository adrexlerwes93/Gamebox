=begin
system "echo -n first" 
system "sleep 1"
system "echo -ne \"\\rsecond\""
system "echo"

system "echo hello"
system "sleep 1"
system "printf \"\\033[1A\"  # move cursor one line up"
system "printf \"\\033[K\"   # delete till end of line"
system "echo foo"
=end

def overwrite(lines)
	count = 0
	while count < lines
		count += 1
		system "printf \"\\033[1A\"  # move cursor one line up"
		system "printf \"\\033[K\"   # delete till end of line"
	end
end

=begin
puts "hello"
puts "my name"
puts "is JOE"
puts "THOMAS"
system "sleep 1"
overwrite(4)
puts "AND ITS GONE!"
=end

puts "hello"
system "printf \"\\033[1A\"  # move cursor one line up"
word = ARGF.read
puts "your word is #{word}"
