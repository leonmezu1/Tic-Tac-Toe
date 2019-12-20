#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/game_engine'
require_relative '../lib/player_engine'

game_new = Game.new('session')
bd = Board.new
main_prompt = true

while main_prompt
  game_new.cl_screen
  puts "\n\t\tWelcome to Tic-Tac-Toe, Let's Game!\n\n"
  puts "\tType 'I' for instructions and learn how to play"
  puts "\tType 'X' to start!"
  start_key = gets.chomp

  case start_key
  when 'I', 'i'
    game_new.cl_screen
    puts "INSTRUCTIONS:\n\n"
    puts "The game is played on a grid that's 3 squares by 3 squares\n"
    puts 'First player is X, second player is O'
    puts 'Players take turns putting their marks in empty square.'
    puts "If there's not second player the computer will take those turns\n\n"
    puts 'The first player to get 3 of her marks in a row'
    puts "(up, down, across, or diagonally) is the winner.\n\n"
    puts 'When all 9 squares are full, the game is over.'
    puts "If no player has 3 marks in a row, the game ends in a tie\n\n\n"
    hold('Press ENTER to continue...')
    game_new.cl_screen
    puts "INSTRUCTIONS:\n\n"
    puts "To select a spot you must specify the row 'A, B or C'\n\n"
    puts "Followed by the column number '1, 2 or 3' and press ENTER\n\n\n"
    hold('Press ENTER to continue...')

  when 'X', 'x'
    game_new.cl_screen
    game_new.game_promt(5)
    main_prompt = false
  else
    game_new.hold('Your input is invalid, press ENTER and try again')
    game_new.cl_screen
  end
end

get_p = true

while get_p
  game_new.mode_selector
  player_n = gets.chomp.to_i

  case player_n
  when 2
    puts "\n\nType the player's ONE nickname:"
    player1 = gets.chomp.to_s
    puts "\n\nType the player's TWO nickname:"
    player2 = gets.chomp.to_s
    game_new.flash("\n\n\n\n\t\t\tLet's play,", 2)
    get_p = false
  when 1
    puts "\n\nType the player's nickname:"
    player1 = gets.chomp.to_s
    game_new.flash("\n\n\n\n\t\t\tDefeat the machine!, GET READY!", 2)
    get_p = false
  else
    game_new.hold('Your input is invalid, press ENTER and try again')
    game_new.cl_screen
  end
end

gaming = true
turn = 0
playable_moves = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]

while turn < 9 && gaming == true
	c_or_d = (turn % 2).eql?(0) ? 'X' : 'O'
	puts c_or_d
  puts "the turn is: #{turn}"
  if turn.odd? && player_n.eql?(1)
    move = playable_moves.sample
    bd.game_input(move, c_or_d)
		playable_moves.delete(move)
		turn += 1
  end

  input_trigger = true
	while input_trigger
		c_or_d = (turn % 2).eql?(0) ? 'X' : 'O'
		puts "|        The last move was: #{move}        |" if turn.positive?
		puts "the turn is: #{turn}"
		puts c_or_d
    bd.board
    puts "| It's your turn #{player1}, show your move or type 'end' for leaving|\n\n" if turn.even?
    puts "| It's your turn #{player2}, show your move or type 'end' for leaving|\n\n" if turn.odd? && player_n.eql?(2)
    move = gets.chomp.to_s
    move.upcase! if move != /[[:upper:]]/.match(move)
    if move == 'END'
      gaming = false
      break
    elsif !playable_moves.include?(move)
      puts 'that movement is not available, check the availables below, press ENTER and try another one, '
      game_new.hold("\n\nThe available moves are: #{playable_moves}\n\n")
    elsif move.match('[A-C][1-3]') && playable_moves.include?(move)
      bd.game_input(move, c_or_d)
      playable_moves.delete(move)
      input_trigger = false
      turn += 1
    else
      game_new.hold('Your input is invalid, press ENTER and try again')
    end
  end
end

game_new.cl_screen
puts "\n\n\t\tThe maximum number of turns is given, the game now decides if:"
puts "\n\n\t\t\tThere's a WINNER or if it's a TIE"
puts "\n\n\t\tThe game also check if there's a winning line since turn >= 3\n\n"
