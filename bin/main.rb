#!/usr/bin/env ruby
# frozen_string_literal: true

require 'io/console'

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
  when 'X', 'x'
    cl_screen
    flash("\n\n\n\n\t\t\tLet's play", "\n\n\n\n\t\t\tTic Tac Toe", 3)
    main_prompt = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end

get_p = true

while get_p
  mode_selector
  player_n = gets.chomp

  case player_n
  when '2'
    cl_screen
    puts "Type the player's ONE nickname:"
    player1 = gets.chomp.to_s
    puts "Type the player's TWO nickname:"
    player2 = gets.chomp.to_s
    flash("\n\n\n\n\t\t\tLet's play,", 2)
    get_p = false
	when '1'
		puts "Type the player's nickname:"
    player1 = gets.chomp.to_s
    flash("\n\n\n\n\t\t\tDefeat the machine!, GET READY!", 2)
    get_p = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end

gaming = true
turn = 0

while gaming

  puts '|-------------------------------------|'
  puts '|-------------------------------------|'
  puts '|-------------------------------------|'
  puts '|                                     |'
  puts '|            | 1 | 2 | 3 |            |'
  puts '|          A | - | - | - |            |'
  puts '|          B | - | - | - |            |'
  puts '|          B | - | - | - |            |'
  puts '|                                     |'
  puts '|-------------------------------------|'
  puts '|-------------------------------------|'
  puts '|-------------------------------------|'
  puts ''
  puts "| It's Your turn #{player1}, show your move |" if turn.even?
  puts "| It's Your turn #{player2}, show your move |" if turn.odd?
  puts "| Or type 'end' for leaving |"

  input_trigger = true
  while input_trigger
    move = gets.chomp.to_s
    if move == 'end'
      gaming = false
      break
    elsif move.match('[a-cA-C][1-3]')
      puts "| You played #{move}"
      input_trigger = false
      turn += 1
    else
      hold('Your input is invalid, press ENTER and try again')
      cl_screen
      input_trigger = false
    end
  end
end
