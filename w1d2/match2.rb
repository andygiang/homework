class Card
  @@deck = []
  def initialize(name,face_up=false)
    @name = name
    @face_up =  face_up
    @@deck << self
  end
  def self.deck
    @@deck
  end
end

class Board
  def initialize(grid_size = 2)
    @grid_size = grid_size
    p @grid = Array.new(grid_size){Array.new(grid_size,nil)}
    scatter(Card.deck)
    p @grid
  end
  def [](pos)
    x,y = pos
    @grid[x][y]
  end
  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end
  def scatter(deck)
    deck.each do |card|
      2.times do
        x,y = rand(@grid_size),rand(@grid_size)
        until (@grid[x][y]).nil?
          x,y = rand(@grid_size),rand(@grid_size)
        end
        @grid[x,y] = card
      end
    end
  end
  def render()
  end
end

apple = Card.new("apple")
bear = Card.new("bear")
Board.new(2)
