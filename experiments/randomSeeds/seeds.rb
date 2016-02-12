seed = Random.new_seed
10.times do 
	rand = Random.new(seed)
	10.times do
		puts rand.rand(1000)
	end
end
puts seed