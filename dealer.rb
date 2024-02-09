# frozen_string_literal: true

require_relative 'player'

# class Dealer
class Dealer < Player
  def make_a_move
    self.state = :stay
    self.state = :hit if points < 17
  end
end
