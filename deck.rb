# frozen_string_literal: true

require_relative 'card'


# class Deck - колода перемешанных карт
class Deck
  def initialize
    @faces = [*(2..10), 'Jack', 'Queen', 'King', 'Ace']
    @suits = %w[♥ ♦ ♣ ♠].freeze # %i[clubs spades hearts diamonds]
    @cards = []
    @faces.each do |face|
      @suits.each { |suit| @cards << Card.new(face, suit) }
    end
    @cards.shuffle!
  end

  def deal(quantity, player)
    quantity.times { player.hand << @cards.shift }
  end
end
