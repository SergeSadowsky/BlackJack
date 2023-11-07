# frozen_string_literal: true

require_relative 'player'
require_relative 'modules/constants'
require_relative 'deck'

class BlackJack
  include Constants
  def initialize
    puts "Black Jack The Last Version"
  end

  def run

    puts 'Greetings! What is your name?'
    name = gets.chomp
    name = name.strip || 'Incognito'
    puts "Welcome #{name}"
    puts 'Would you like to play?'

    # show first menu

    # if yes
    human = Player.new(name, INITIAL_MONEY)
    dealer = Player.new('Dealer', INITIAL_MONEY)

    deck = Deck.new
    deck.deal(2, human)
    deck.deal(2, dealer)

    human.show_hand
    dealer.show_hand

    puts deck.inspect




    # ask user name
    # create player
    # shuffle deck
    # deal cards to player
    # dead cards to dealer
    # show cards info to user (cards, points)
    # make bets
    # ask



  end
end
