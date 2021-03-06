require_relative "deck"
class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    total = 0
    @cards.each do |card|
      if card.value == :ace
        if total <= 10
          total+= 11
        else
          total+=1
        end

      else
        total += Card::BLACKJACK_VALUE[card.value]
      end
    end
    total
  end

  def busted?
    return true if points > 21
    return false
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards = deck.take(1)
  end

  def beats?(other_hand)
    return true if other_hand.busted?
    return false if self.busted?
    return false if other_hand.points == self.points
    return true if other_hand.points < self.points
    return false
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
