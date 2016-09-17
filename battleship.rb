class Board
	attr_reader :grid,:size
	def initialize(size=10)
		@size = size
		@grid = Array.new(size){Array.new(size,nil)}
	end
	def scatter(ships)
		ships.each do |ship|
			x,y = rand(size-1),rand(size-1)
			horizontal_or_vertical = rand(2)
			#0 = horizontal 1=vertical
			until clear([x,y],ship,horizontal_or_vertical)
				x,y = rand(size-1),rand(size-1)
				horizontal_or_vertical = rand(2)
			end
			if horizontal_or_vertical == 1
				for j in 0...ship.length
				  grid[x][y+j] = ship.name
				end
			else
				for i in 0...ship.length
					grid[x+i][y] = ship.name
				end
			end
		end
	end
	def clear(point,ship,horizontal_or_vertical)
		x,y = point
		return false if x+ship.length>= size or y+ship.length>=size
		if horizontal_or_vertical == 1
			for j in 0...ship.length
				return false if grid[x][y+j] != nil
			end
		else
			for i in 0...ship.length
				return false if grid[x+i][y] != nil
			end
		end
		return true
	end
  def [](postion)
    x,y = position
    grid[x][y]
  end
  def []=(position,value)
  	x,y = position
    grid[x][y] = value
  end
	def fire(point)
		x,y = point
		unless grid[x][y] == nil
			puts "HIT!"
			return grid[x][y]
		else
			puts "Miss!"
			grid[x][y]=:miss
			return :miss
		end
	end
end
class Ship
	attr_reader :name,:length
	def initialize(name,length)
		@name = name
		@length = length
		@@fleet << self
	end
	submarine = Ship.new(:SUB,3)
	battleship = Ship.new(:BS,4)
	aircraft_carrier = Ship.new(:AC,5)
	@@fleet = [submarine,battleship,aircraft_carrier]
	def self.fleet
		@@fleet
	end
end
class Player
	def initialize
	end
	def self.prompt
		puts "enter row"
		row = Integer(gets.chomp)
		puts "enter col"
		col = Integer(gets.chomp)
		return [row,col]
	end
end
class Battle
	attr_reader :human_board,:computer_board
	def initialize(size=10)
		@computer_board = Board.new(size)
		@computer_board.scatter(Ship.fleet)
		@human_board = Board.new(size)
		play
		puts "Win"
	end
	def play
		guesses = []
		while human_board.grid != @computer_board.grid
			puts "human"
			p human_board.grid
			print "guesses:"
			p guesses
			target = Player.prompt
			if guesses.include?(target)
				puts "already guessed Try again"
				next
			elsif target.any?{|num| num >= @computer_board.size}
				puts "out of range"
				next
			else
				guesses << target
				guesses = guesses.sort
			end
			puts "ready to fire: #{target}"
			uncovered = @computer_board.fire(target)
			if uncovered!= :miss
				human_board[target]= uncovered
			else
				human_board[target]=:miss
			end
		end
	end
end

Battle.new(10)
