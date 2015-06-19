require 'rubygems'
require 'gosu'

class MinBall
	def initialize(window)
		@image = Gosu::Image.new(window,"ball.png",false)
		@x = 225*(Math.sin(((Time.now.to_f/60.0)/60.0)*2*Math::PI)+1)
		@y = 225*(0-Math.cos(((Time.now.to_f/60.0)/60.0)*2*Math::PI)+1)
	end

	def draw
		@image.draw(@x,@y,1)
	end

	def move
		@x = 225*(Math.sin(((Time.now.to_f/60.0)/60.0)*2*Math::PI)+1)
		@y = 225*(0-Math.cos(((Time.now.to_f/60.0)/60.0)*2*Math::PI)+1)
	end
end

class SecBall
	def initialize(window)
		@image = Gosu::Image.new(window,"ball.png",false)
		@x = 225*(Math.sin(((Time.now.to_f)/60.0)*2*Math::PI)+1)
		@y = 225*(0-Math.cos(((Time.now.to_f)/60.0)*2*Math::PI)+1)
	end

	def draw
		@image.draw(@x,@y,1)
	end

	def move
		@x = 225*(Math.sin(((Time.now.to_f)/60.0)*2*Math::PI)+1)
		@y = 225*(0-Math.cos(((Time.now.to_f)/60.0)*2*Math::PI)+1)
	end
end

class GameWindow < Gosu::Window
	def initialize
		super 500,500,false
		self.caption = "Gosu Tutorial Game"
		@second_ball=SecBall.new(self)
		@minute_ball=MinBall.new(self)
	end

	def update
		@second_ball.move
		@minute_ball.move
		self.caption = Time.now
	end

	def draw
		@second_ball.draw
		@minute_ball.draw
	end
end

window = GameWindow.new

window.show


