# frozen_string_literal: true

# class Card
#
#
class Card
  attr_reader :face, :suit, :value

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = card_value
  end

  def to_s
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
