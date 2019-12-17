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

def flash(*promt)
  0.upto(20) do
    STDOUT.puts promt[0].to_s if promt[0].respond_to?(:to_s)
    sleep 0.25
    cl_screen
    STDOUT.puts promt[1].to_s if promt[1].respond_to?(:to_s)
    sleep 0.25
    print "            \r"
    cl_screen
  end
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
    flash("Let's play", 'Tic Tac Toe')
    main_prompt = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end
