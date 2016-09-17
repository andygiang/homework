class Tile
  attr_accessor :value
  attr_reader :revealed
  def initialize(value=nil,revealed=false,flagged=false)
    @value = value
    @revealed = revealed
  end
end
class Board
  attr_reader :board
   def initialize
     @board = Array.new(9) {Array.new(9) {Tile.new} }
   end
  def scatter_bombs
    10.times do
      x,y = rand(9),rand(9)
      until @board[x][y].value == nil
         rand_pos = [rand(9),rand(9)]
       end
       @board[x][y].value  = :bomb
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
        next if @board[x][y].value == :bomb
        neighbors = adjacent_tiles([i,j])
        count = 0
        neighbors.each do |neighbor|
          if @board[x][y].value == :bomb
            count+=1
          end
        end
        @board[x][y].value = count
      end
    end
  end
  def render
    @board.each do |row|
      p row.collect {|tile| tile.value}
    end
  end
  def win?
    @board.flatten.all? {|tile| tile.revealed == true}
  end
  def prompt_pos
    puts "enter a row,col"
    row,col = gets.chomp.split(',').map(&:to_i)
    [row,col]
  end
  def prompt_flag
    puts "flag or safe"
    flag = gets.chomp
  end
  def update_position
    x,y = prompt_pos
    flag = prompt_flag
    if flag == 'safe'
      @board[x][y].revealed == true
      wave([x,y])
    else
      @board[x][y].flagged == true
    end
  end
  def wave(pos)
    x,y = pos
    top = [x,y+1]
    bottom = [x,y-1]
    left = [x+1,y]
    right = [x-1,y]
    neighbors = [top,bottom,left,right]
    return nil if neighbors.all? do |coor|
      tile = @board[coor.first][coor.last]
      tile.revealed == true or tile.value > 0 or tile.value == :bomb
    end
    if @board[x][y] == 0
      neighbors.each do |coor|
        @board[coor.first][coor.last].revealed == true
        wave(coor)
      end
    end
  end

end


a = Board.new
a.render
a.scatter_bombs
a.scatter_numbers
a.update_position
a.render
