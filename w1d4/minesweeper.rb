class Tile
  attr_accessor :value
  attr_reader :revealed
  def initialize(value=nil,revealed=false)
    @value = value
    @revealed = revealed
  end
end
class Board
  attr_reader :board
   def initialize
     @board = Array.new(9) {Array.new(9) {Tile.new} }
   end
  def [](pos)
    x,y = pos
    @board[x][y]
  end
  def []=(pos,value)
    x,y = pos
    @board[x][y].value = value
  end
  def scatter_bombs
    10.times do
      rand_pos = [rand(9),rand(9)]
      until self[rand_pos].value == nil
         rand_pos = [rand(9),rand(9)]
       end
       self[rand_pos]  = :bomb
     end
  end
  def adjacent_tiles(pos)
    x,y = pos
    all_pos = []
    for i in -1..1
      for j in -1..1
        all_pos << [x+i,y+j]
      end
    end
    all_pos = all_pos.select {|x,y| x<9 and y<9 and x >=0 and y >=0}
  end
  def scatter_numbers
    for i in 0...9
      for j in 0...9
        next if self[[i,j]].value == :bomb
        neighbors = adjacent_tiles([i,j])
        count = 0
        neighbors.each do |neighbor|
          if self[neighbor].value == :bomb
            count+=1
          end
        end
        self[[i,j]] = count
      end
    end
  end
  def render
    @board.each do |row|
      p row.collect {|tile| tile.value}
    end
  end
end

a = Board.new
a.render
a.scatter_bombs
a.scatter_numbers
a.render
