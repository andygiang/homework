require_relative 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def place_bet(dealer, amt)
    raise "Dealer doesn't bet"
  end

  def play_hand(deck)
    until @hand.points >= 17
      @hand +=deck.take(1)
    end
  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets

  end
end
