def timeEverySecond
	while true
		system "clear"
		oldTime = Time.now.strftime("%S")
		puts Time.now.strftime("%I:%M %S %p")
		until Time.now.strftime("%S") != oldTime
		end
	end
end

def timeAllTheTime
	while true
		puts Time.now.strftime("%I:%M %S %p")
	end
end

def 

###############################################################################

#timeEverySecond

#timeAllTheTime