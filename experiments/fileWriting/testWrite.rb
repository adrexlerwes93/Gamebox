scores = ""
File.open('scores.txt', 'r+') do |file|
	scores = File.read(file)
end

#File.open('testWrite.txt', 'w') do |file|
#	file.puts "Hello Catherine!"
#	file.print "My name was"
#	file.print " A"
#end
oldNewLine = 0
newLine = 0
newLineCount = scores.count("\n")
newLineCount.times do
	oldNewLine = newLine
	newLine = scores.index("\n")
	print oldNewLine.to_s+","+newLine.to_s+"\n"
	puts scores[oldNewLine,newLine]
	scores = scores.sub("\n", " ")
end
#puts scores

def updateScore(game, score)

end