class Tile
  def initialized(value,revealed=false,flagged=false)
    @value = value
    @revealed = revealed
    @flagged = flagged
  end
end
class Board
  def initialized()
    @board = Array.new(9){Array.new(9,Tile.new(nil))}
  end
  def [](pos)
    x,y = pos
    @board[x][y]
  end
  def []=(pos,value)
    x,y = pos
    @board[x][y] = value
  end
  def scatter_bombs
    10.times do
      rand_pos = nil
      until @board[rand_pos].value == nil
         rand_pos = [rand(9),rand(9)]
       end
       @board[rand_pos].value = :bomb
     end
  end
  def adjacent_tiles(pos)
    x,y = pos
    top = [x,y+1]
    top_right = [x+1,y+1]
    top_left = [x-1,y+1]
    right = [x+1,y]
    left = [x-1,y]
    bottom = [x,y-1]
    bottom_right = [x+1,y-1]
    bottom_left = [x-1,y-1]
    all_pos = [top,top_left,top_right,right,left,bottom,bottom_left,bottom_right]
    all_pos = all_pos.select {|x,y| x<9 and y<9 and x >=0 and y >=0}
  end
end
