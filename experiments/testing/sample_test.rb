require "test/unit"

class SimpleTest < Test::Unit::TestCase
	def test_simple
		a = true
		b = false
		assert(a)
		assert(!b)
	end
end
