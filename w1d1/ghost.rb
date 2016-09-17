class Game
  def initialize(*players)
    @players = players
    @fragment = ''
    @dictionary = File.readlines("dictionary.txt").map{|word|word.chomp}
    @current_index = 0
    play
  end
  def play
    puts "lets play"
    until @dictionary.include?(@fragment) #until word is found
      puts "Current fragment: " + @fragment
      puts "#{@players[@current_index].name} turn"
      puts "guess a the next letter"
      letter = gets.chomp
      until valid_play?(letter)
        puts "try again"
        puts "guess a the next letter"
        letter = gets.chomp
      end
      @fragment = @fragment + letter
      switch_current_player
    end
    puts @fragment
    puts "#{@players[@current_index].name} wins!"
end
  def valid_play?(letter)
    return false if letter.length > 1
    @dictionary.any?{|word| word =~ Regexp.new(@fragment + letter)}
  end
  def switch_current_player
    if @current_index == 0
      @current_index = 1
    else
      @current_index = 0
    end
  end
end

class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

andy = Player.new("andy")
tony = Player.new("tony")
Game.new(andy,tony)
