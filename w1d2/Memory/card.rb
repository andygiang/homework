class Card
  attr_reader :value,:face_up
  def initialize(value, face_up=false)
    @value = value
    @face_up = face_up
  end

  def face
    return @value if @face_up
    return nil
  end

  def reveal
    @face_up = true
  end
end

class HumanPlayer
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Board

  @@deck = [
    Card.new("leaf"),
    Card.new("car"),
  ]

  attr_reader :grid_size

  def initialize(grid_size = 2)
    @grid_size = grid_size
    @grid = Array.new(grid_size) {Array.new(grid_size)}
    populate
    @grid

  end

  def populate
    @@deck.each do |card|
      2.times do
        i, j = rand(2), rand(2)
        until @grid[i][j].nil?
          i, j = rand(2), rand(2)
        end
        @grid[i][j] = card #populate grid square with card
      end
    end
  end

  def render(pos)
    p self[pos].value
  end

  def display
    display = Array.new(@grid_size) {Array.new(@grid_size)}

    for i in 0...@grid_size
      for j in 0...@grid_size
        display[i][j] = @grid[i][j].face
      end
    end
    display.each do |col|
      p col
    end
  end

  def [](pos)
    x,y = pos[0],pos[1]
    @grid[x][y]
  end

  def over?
    return true if @grid.flatten.all?{|card| card.face_up == true}
    return false
  end
end

class Game
  def initialize
    @board = Board.new
  end

  def play
    until @board.over?
      @board.display
      pos1 = prompt
      @board.render(pos1)
      pos2 = prompt
      check(pos2, pos1)
    end
    puts "game"
  end

  def prompt
    puts "pick row,col"
    pos = gets.chomp

    pos = pos.split(',').map{|num|num.to_i}
    valid_nums = (pos.all? { |int| int.class == Fixnum && int < @board.grid_size})
    valid_length = (pos.length == 2)

    until  valid_nums && valid_length
      puts "invalid input"
      puts "pick row,col"
      pos = gets.chomp

      pos = pos.split(',').map{|num|num.to_i}
      valid_nums = (pos.all? { |int| int.class == Fixnum && int < @board.grid_size})
      valid_length = (pos.length == 2)
    end
    pos
  end

  def check(pos, prev_pos)
    if @board[pos].value == @board[prev_pos].value
      @board[pos].reveal
      @board[prev_pos].reveal
      puts "matched"
    else
      puts "not a match"
    end
  end
end

game = Game.new
game.play
