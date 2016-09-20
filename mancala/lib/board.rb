class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14,[])
    place_stones
  end

  def place_stones
    for i in 0..5
      @cups[i] = [:stone]*4
    end
    for i in 7..12
      @cups[i] = [:stone]*4
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    quanity = @cups[start_pos].length
    current_pos = start_pos
    @cups[start_pos] = []
    until quanity == 0
      current_pos +=1
      current_pos -= 14 if current_pos == 14
      next if current_pos == 6 and current_player_name != @name1
      next if current_pos == 13 and current_player_name != @name2
      @cups[current_pos] += [:stone]
      quanity-=1
    end
    render
    next_turn(current_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if ending_cup_idx == 6 or ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def cups_empty?
    @cups.take(6).all? { |cup| cup.empty? } ||
    @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length
    return @name1 if @cups[6].length > @cups[13].length
    return @name2
  end
end
