require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    all_cards = []
    Card::SUIT_STRINGS.each do |suit_sym,suit|
      Card::VALUE_STRINGS.each do |value_sym,value|
        all_cards << Card.new(suit_sym,value_sym)
      end
    end
    all_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.length
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if @cards.length < n
    @cards.shift(n)

  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards += cards
  end
end
