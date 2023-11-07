# frozen_string_literal: true

require_relative 'card'

# class Deck - колода перемешанных карт
# конструктор
# метод Deal
class Deck
  def initialize
    @faces = [*(2..10), 'Jack', 'Queen', 'King', 'Ace']
    @suits = %i[clubs spades hearts diamonds]
    @cards = []
    @faces.each do |face|
      @suits.each { |suit| @cards << Card.new(face, suit) }
    end
    @cards.shuffle!
  end

  def deal(num, player)
    num.times { player.hand << @cards.shift }
  end
end
