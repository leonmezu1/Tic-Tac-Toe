#!/usr/bin/env ruby
# frozen_string_literal: true

require '../lib/game_engine.rb'
require '../lib/player_engine.rb'

def game_promt(times)
  0.upto(times) do
    cl_screen
    sleep 0.35
    puts '.____           __ /\          ________                       '
    puts '|    |    _____/  |)/ ______  /  _____/_____    _____   ____  '
    puts '|    |  _/ __ \   __\/  ___/ /   \  ___\__  \  /     \_/ __ \ '
    puts '|    |__\\  ___/|  |  \\___ \\  \\    \\_\\  \\/ __ \\|  Y Y  \\  ___/ '
    puts '|_______ \\___  >__| /____  >  \\______  (____  /__|_|  /\\___  >'
    puts '        \\/   \\/          \\/          \\/     \\/      \\/     \\/ '
    puts '																										          '
    sleep 0.35
  end
end

def cl_screen
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end
end

def hold(prompt = nil)
  print prompt
  STDIN.getch
  print "            \r"
end

def flash(*prompt)
  0.upto(prompt[-1]) do
    cl_screen
    STDOUT.puts prompt[0].to_s if prompt[0].respond_to?(:to_s)
    sleep 0.35
    cl_screen
    STDOUT.puts prompt[1].to_s if prompt[1].is_a?(String)
    sleep 0.35
    print "            \r"
  end
end

def mode_selector
  cl_screen
  puts '| ------------------------------------- |'
  puts '|          SELECT YOUR GAME MODE!       |'
  puts '| ------------------------------------- |'
  puts '|                                       |'
  puts '|           1: SINGLE PLAYER            |'
  puts '|          2: MULTIPLAYER PLAYER        |'
  puts '|                                       |'
  puts '| ------------------------------------- |'
  puts ''
end

main_prompt = true

while main_prompt
  cl_screen
  puts "\n\t\tWelcome to Tic-Tac-Toe, Let's Game!\n\n"
  puts "\tType 'I' for instructions and learn how to play"
  puts "\tType 'X' to start!"
  start_key = gets.chomp

  case start_key
  when 'I', 'i'
    cl_screen
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
    cl_screen
    puts "INSTRUCTIONS:\n\n"
    puts "To select a spot you must specify the row 'A, B or C'\n\n"
    puts "Followed by the column number '1, 2 or 3' and press ENTER\n\n\n"
    hold('Press ENTER to continue...')

  when 'X', 'x'
    cl_screen
    game_promt(5)
    main_prompt = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end

get_p = true

while get_p
  mode_selector
  player_n = gets.chomp.to_i

  case player_n
  when 2
    puts "\n\nType the player's ONE nickname:"
    player1 = gets.chomp.to_s
    puts "\n\nType the player's TWO nickname:"
    player2 = gets.chomp.to_s
    flash("\n\n\n\n\t\t\tLet's play,", 2)
    get_p = false
  when 1
    puts "\n\nType the player's nickname:"
    player1 = gets.chomp.to_s
    flash("\n\n\n\n\t\t\tDefeat the machine!, GET READY!", 2)
    get_p = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end

gaming = true
playable_moves = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]
turn = 0

while turn < 9 && gaming == true
  board
  if turn.odd? && player_n.eql?(1)
    cl_screen
    move = playable_moves.sample
    board
    puts "| The machine played #{move} |"
    turn += 1
    playable_moves.delete(move)
  end

  input_trigger = true
  while input_trigger
    puts "| It's your turn #{player1}, show your move or type 'end' for leaving|\n\n" if turn.even?
    puts "| It's your turn #{player2}, show your move or type 'end' for leaving|\n\n" if turn.odd? && player_n.eql?(2)
    move = gets.chomp.to_s
    move.upcase! if move != /[[:upper:]]/.match(move)
    if move == 'END'
      gaming = false
      break
    elsif !playable_moves.include?(move)
      hold('that movement is not available, check the availables below, press ENTER and try another one, ')
      puts "\n\nThe available moves are: #{playable_moves}\n\n"
    elsif move.match('[A-C][1-3]') && playable_moves.include?(move)
      cl_screen
      puts "| The last move was: #{move}"
      playable_moves.delete(move)
      input_trigger = false
      turn += 1
    else
      hold('Your input is invalid, press ENTER and try again')
      cl_screen
    end
  end
end

cl_screen
puts "\n\n\t\tThe maximum number of turns is given, the game now decides if:"
puts "\n\n\t\t\tThere's a WINNER or if it's a TIE"
puts "\n\n\t\tThe game also check if there's a winning line since turn >= 3\n\n"
