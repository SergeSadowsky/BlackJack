# frozen_string_literal: true

require_relative 'modules/interaction'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

# class BlackJack
class BlackJack

  INITIAL_MONEY = 100
  BET = 10
  BJ = 21

  IA = Interaction

  def initialize
    @players = { human: nil, dealer: nil }
    @bank = 0
    @deck = nil
  end

  def run

    player_name = IA.ask_name
    IA.say_msg "Hi, #{player_name}!"
    unless IA.ask_yn 'Would you like to play?'
      IA.say_msg "Very sorry. \nBye...\n"
      exit(0)
    end
    players[:human] = Player.new(player_name, INITIAL_MONEY)
    players[:dealer] = Dealer.new('Dealer', INITIAL_MONEY)

    loop do
      self.deck = Deck.new
      players_init
      IA.show_cards(players[:human])

      if black_jack?(players[:human])
        players[:human].get_payout(payout)
        IA.show_winner(players[:human])
      else
        players[:human].make_a_move do
          IA.ask_player
        end
        send players[:human].state
      end
      puts "You have #{players[:human].money} buck(s)."
      unless IA.ask_yn 'Wanna play again?'
        IA.say_msg "Very sorry. \nBye...\n"
        break
      end
      players.each_value(&:hand_reset)
    end
  end

  private

  attr_accessor :players, :deck, :bank

  def open
    players.each_value { |player| IA.show_cards(player) }
    finalize_round
  end
  
  def hit
    deck.deal(1, players[:human])
    players[:dealer].make_a_move
    deck.deal(1, players[:dealer]) if players[:dealer].state == :hit
    send :open
  end
  
  def stay
    players[:dealer].make_a_move
    deck.deal(1, players[:dealer]) if players[:dealer].state == :hit
    IA.show_cards(players[:human])
    players[:human].make_a_move do
      IA.ask_player(2)
    end
    send players[:human].state
  end

  def players_init
    players.each_value do |player|
      deck.deal(2, player)
      begin
        self.bank += player.make_bet(BET)
      rescue StandardError => e
        IA.say_msg "#{e.message} Very sorry. \nBye...\n"
        exit(0)
      end
    end
  end

  def finalize_round
    winner = select_winner
    if winner.nil?
      money = payout / players.size
      players.each_value { |player| player.get_payout(money) }
      IA.show_draw
    else
      winner.get_payout(payout)
      IA.show_winner(winner)
    end
  end

  def black_jack?(player)
    player.points == BJ
  end

  def select_winner
    winner = nil
    players.each_value do |player|
      if player.points <= BJ
        winner = player if winner.nil? || (BJ - winner.points > BJ - player.points)
      end
    end
    winner
  end

  def payout
    money = bank
    self.bank = 0
    money
  end
end
