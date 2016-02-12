def timeEverySecond
	while true
		oldTime = Time.now.strftime("%S")
		puts Time.now.strftime("%I:%M %S %p")
		until Time.now.strftime("%S") != oldTime
			wait 30
		end
		system "printf \"\\033[1A\""
      	system "printf \"\\033[K\""
	end
end

def timeAllTheTime
	while true
		puts Time.now.strftime("%I:%M %S %p")
	end
end

###############################################################################

timeEverySecond

#timeAllTheTime