# frozen_string_literal: true

class Card
  attr_accessor :face, :suit, :value
  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = card_value
  end

  def to_s
    super
    "#{face} of #{suit}"
  end

  private

  def card_value
    if face.instance_of?(Integer)
      face
    elsif face == 'Ace'
      11
    else
      10
    end
  end
end
