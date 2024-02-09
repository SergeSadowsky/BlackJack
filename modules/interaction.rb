# frozen_string_literal: true

# module Interaction
module Interaction

  OPTIONS = { open: 'Open (Open hands)',
              hit: 'Hit (Take another card)',
              stay: 'Stay (Take no more cards)' }.freeze

  def self.ask_name
    puts 'Greetings! What is your name?'
    name = gets.chomp
    name.strip || 'Incognito'
  end

  def self.ask_yn(msg)
    puts "#{msg}(Y/n)"
    answer = gets.chomp.downcase
    raise ArgumentError, 'Please enter "y" or "n".' unless ['', 'y', 'n'].include?(answer)

    answer != 'n'
  rescue StandardError => e
    puts e.message
    retry
  end

  def self.ask_option(msg, err_msg, max = 3)
    print msg
    result = Integer(gets.chomp)
    raise ArgumentError if result.negative? || result > max

    result
  rescue TypeError, ArgumentError
    puts err_msg
    retry
  end

  def self.show_options(num_of_options = 3)
    options = OPTIONS.keys[0, num_of_options]
    options.each_with_index do |key, index|
      puts "#{index + 1} - #{OPTIONS[key]}  "
    end
    puts ''
  end

  def self.ask_player(opt_quantity = 3)
    show_options(opt_quantity)
    option = Interaction.ask_option('Select option: ', 'Please enter correct numeric value.', opt_quantity) - 1
    Interaction::OPTIONS.keys[option]
  end

  def self.show_cards(player)
    puts "#{player.name} hand:"
    puts player.hand.join(', ')
    puts "It's #{player.points} points \n\n"
  end
  
  def self.show_winner(player)
    puts "\nThe winner is #{player.name}\n\n\n"
  end

  def self.show_draw
    puts "\nNobody win.\n\n\n"
  end

  def self.say_msg(text)
    puts text
  end
end
