require 'colorize'
require 'byebug'

class Tile
  attr_accessor :given,:value

  def initialize(value=nil,given=false)
    @value = value
    @given = given
  end

end

class Board
  attr_accessor :grid
  def initialize(grid=nil)
    @grid = Array.new(9){Array.new(9){"*"}}
    for i in 0...9
      for j in 0...9
        if grid[i][j] == '0'
          @grid[i][j] = Tile.new()
        else
          @grid[i][j] = Tile.new(grid[i][j],true)
        end
      end
    end
  end

  def render
    # display_board = Array.new(9){Array.new(9){"*"}}
    for i in 0...9
      print "row #{i}:   "
      for j in 0...9
        if @grid[i][j].value.nil?
          print nil.inspect
        elsif @grid[i][j].given
          print ' '
          print @grid[i][j].value.colorize(:green)
          print ' '
        else
          print ' '
          print @grid[i][j].value.inspect
          print ' '
        end
        print ' '
        print '|' if (j+1)%3 == 0 unless j == 8
      end
      puts " "
      print "         "
      puts "____________|" * 2 + "____________" if (i+1)%3==0 && i != 8
      puts (" "* 12 + "|") * 2 unless i % 3 == 2

    end
    # display_board
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    (@grid[x][y]).value = value
  end

  def won?
    return false if @grid.flatten.any? {|tile| tile.value.nil? }

    soln = ('1'..'9').to_a
    colums = []

    #check rows
    @grid.each do |rw|
      row = rw.map {|tile| tile.value}
      return false unless row.sort == soln
    end
    #check columns
    @grid.transpose.each do |col|
      column = col.map {|tile| tile.value}
      column.sort == soln
    end

    #check boxes

    0.step(8,3) do |i|
      chunk = @grid.slice(i,3)
      0.step(8,3) do |j|
        chunk = chunk.transpose.slice(j,3)
        p chunk = chunk.flatten.map{|tile| tile.value}
      end
    end


  end

  def get_chunk
    debugger
    0.step(8,3) do |i|
      chunk = @grid.slice(i,3)
      0.step(8,3) do |j|
        chunk = chunk.transpose.slice(j,3)
        p chunk = chunk.flatten.map{|tile| tile.value}
      end
    end
  end
end

class Game
  attr_accessor :board
  def initialize(board)
    @board = board

  end

  def prompt_position
    puts "\npick row,col"
    pos = gets.chomp

    pos = pos.split(',').map{|num|num.to_i}
    valid_nums = (pos.all? { |int| int.class == Fixnum && int < 9})
    valid_length = (pos.length == 2)

    until  valid_nums && valid_length
      puts "invalid input"
      puts "\npick row,col"
      pos = gets.chomp

      pos = pos.split(',').map{|num|num.to_i}
      valid_nums = (pos.all? { |int| int.class == Fixnum && int < 9})
      valid_length = (pos.length == 2)
    end
    pos
  end

  def prompt_value
    puts "enter a value:"
    value = Integer(gets.chomp)
  end

  def update_tile(pos, value)
    @board[pos]= value unless @board[pos].given == true
  end

  def play
    until @board.won?
      @board.render
      pos = prompt_position
      val = prompt_value
      update_tile(pos,val)
    end
  end
end

grid = File.readlines("suduko1.txt").map{|row| row.strip.split("")}
board = Board.new(grid)
game = Game.new(board)

if __FILE__ == $PROGRAM_NAME
  game.play
end
