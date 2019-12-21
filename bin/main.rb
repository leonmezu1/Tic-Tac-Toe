#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/game_engine'
require_relative '../lib/player_engine'

game_new = Game.new('session')
bd = Board.new

def cl_screen
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end
end

def game_promt(times)
  0.upto(times) do
    cl_screen
    sleep 0.35
    puts "\n" * 3
    puts "\t" + '.____           __ /\          ________                       '
    puts "\t" + '|    |    _____/  |)/ ______  /  _____/_____    _____   ____  '
    puts "\t" + '|    |  _/ __ \   __\/  ___/ /   \  ___\__  \  /     \_/ __ \ '
    puts "\t" + '|    |__\\  ___/|  |  \\___ \\  \\    \\_\\  \\/ __ \\|  Y Y  \\  ___/ '
    puts "\t" + '|_______ \\___  >__| /____  >  \\______  (____  /__|_|  /\\___  >'
    puts "\t" + '        \\/   \\/          \\/          \\/     \\/      \\/     \\/ '
    puts "\t" + '																										          '
    sleep 0.35
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
    game_promt(3)
    main_prompt = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end

get_p = true

while get_p
  puts game_new.mode_selector
  player_n = gets.chomp.to_i

  case player_n
  when 2
    puts "\n\nType the player's ONE nickname:"
    name1 = gets.chomp.to_s
    puts "\n\nType the player's TWO nickname:"
    name2 = gets.chomp.to_s
    flash("\n\n\n\n\t\t\tLet's GAME,", 2)
    player1 = Player.new(name1)
    player2 = Player.new(name2)
    get_p = false
  when 1
    puts "\n\nType the player's nickname:"
    name1 = gets.chomp.to_s
    flash("\n\n\n\n\t\t\tDefeat the machine!, GET READY!", 2)
    player1 = Player.new(name1)
    get_p = false
  else
    hold('Your input is invalid, press ENTER and try again')
    cl_screen
  end
end

gaming = true
turn = 0
playable_moves = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]

while turn < 9 && gaming == true
  c_or_d = turn.even? ? 'X' : 'O'
  if turn.odd? && player_n.eql?(1)
    move = playable_moves.sample
    bd.game_input(move, c_or_d)
    playable_moves.delete(move)
    turn += 1
    flag = bd.win_scenario
    break if flag.size > 1 && turn > 2
  end

  input_trigger = true
  while input_trigger
    c_or_d = turn.even? ? 'X' : 'O'
    puts "|        The last move was: #{move}        |" if turn.positive?
    puts bd.board
    puts "| It's your turn #{player1.name}, show your move or type 'end' for leaving|\n\n" if turn.even?
    if turn.odd? && player_n.eql?(2)
      puts "| It's your turn #{player2.name}, show your move or type 'end' for leaving|\n\n"
    end
    move = gets.chomp.to_s
    cl_screen
    move.upcase! if move != /[[:upper:]]/.match(move)
    if move == 'END'
      gaming = false
      break
    elsif !playable_moves.include?(move)
      puts 'that movement is not available, check the availables below, press ENTER and try another one, '
      hold("\n\nThe available moves are: #{playable_moves}\n\n")
    elsif move.match('[A-C][1-3]') && playable_moves.include?(move)
      bd.game_input(move, c_or_d)
      playable_moves.delete(move)
      input_trigger = false
      turn += 1
    else
      hold('Your input is invalid, press ENTER and try again')
      cl_screen
    end
  end
  next unless turn > 2

  flag = bd.win_scenario
  puts flag
  break if flag.size > 1
end

cl_screen
puts "\n" * 3

if flag[0] && flag.size > 1
  puts "\t" + '__      __.__ '
  puts "\t" + '/  \\    /  \\__| ____   ____   ___________ '
  puts "\t" + '\\   \\/\\/   /  |/    \\ /    \\_/ __ \_  __ \\'
  puts "\t" + ' \\        /|  |   |  \\   |  \\  ___/|  | \\/'
  puts "\t" + '  \\__/\\  / |__|___|  /___|  /\\___  >__|   '
  puts "\t" + '       \\/          \\/     \\/     \\/       '
  puts "\n" * 4
  puts "\t\t\t + #{player1.name} + \n\n" if flag[1].eql?('X')
  puts "\t\t\t + #{player2.name} + \n\n" if flag[1].eql?('O') && player_n.eql?(2)
  puts "\t\tM A C H I N E\n\n" if flag[1].eql?('O') && player_n.eql?(1)
else
  puts "\t" + '	___________.__        '
  puts "\t" + '\\__    ___/|__| ____  '
  puts "\t" + '  |    |   |  |/ __ \\ '
  puts "\t" + '  |    |   |  \\  ___/ '
  puts "\t" + '  |____|   |__|\___  >'
  puts "\t" + '                   \\/ '
end
