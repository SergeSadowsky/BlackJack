# frozen_string_literal: true

class Player
  attr_accessor :name, :money, :hand, :total

  def initialize(name, money)
    @name = name
    @money = money
    @hand = []
    @total
  end

  def show_hand
    @hand.each { |card| print card, ' ' }
    puts ''
  end
end
