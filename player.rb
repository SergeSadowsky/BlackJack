# frozen_string_literal: true

# class Player - 
class Player
  attr_reader :name, :money, :hand, :state

  def initialize(name, money)
    @name = name
    @money = money
    @hand = []
    @state = nil
  end

  def hand_reset
    self.hand = []
  end

  def make_bet(bet)
    self.money -= bet
    raise StandardError, "#player.name haven\'t enough money to resume game." if self.money.negative?

    bet
  end

  def get_payout(payout)
    self.money += payout
  end

  def make_a_move
    self.state = yield
  end

  def points
    result = hand.reduce(0) { |sum, card| sum + card.value }
    if result > 21
      ace_count = hand.count { |el| el.value == 11 }
      result -= 10 if ace_count.positive?
      result -= 10 if result > 21 && ace_count > 1
    end
    result
  end

  private

  attr_writer :money, :hand, :state

end
