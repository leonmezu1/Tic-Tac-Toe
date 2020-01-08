# frozen_string_literal: true

# executability tested again

# rubocop: disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity

require_relative 'player_engine'
require 'io/console'

class Game
  def initialize(session)
    @session = session
  end

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

  def mode_selector
    cl_screen
    @select = ['| ------------------------------------- |',
               '|          SELECT YOUR GAME MODE!       |',
               '| ------------------------------------- |',
               '|                                       |',
               '|           1: SINGLE PLAYER            |',
               '|          2: MULTIPLAYER PLAYER        |',
               '|                                       |',
               '| ------------------------------------- |',
               '']
  end
end

class Board
  attr_accessor :key, :playable_moves, :turn
  def initialize
    @key = {
      A1: '-', A2: '-', A3: '-',
      B1: '-', B2: '-', B3: '-',
      C1: '-', C2: '-', C3: '-'
    }
    @turn = 0
    @playable_moves = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]
  end

  def game_input(chain, value)
    @key[chain.to_sym] = value
  end

  def board
    @arr = ['|-------------------------------------|',
            '|-------------------------------------|',
            '|-------------------------------------|',
            '|                                     |',
            '|            | 1 | 2 | 3 |            |',
            "|          A | #{@key[:A1]} | #{@key[:A2]} | #{@key[:A3]} |            |",
            "|          B | #{@key[:B1]} | #{@key[:B2]} | #{@key[:B3]} |            |",
            "|          C | #{@key[:C1]} | #{@key[:C2]} | #{@key[:C3]} |            |",
            '|                                     |',
            '|-------------------------------------|',
            '|-------------------------------------|',
            '|-------------------------------------|',
            '']
  end

  def win_scenario
    output = []
    %w[X O].each do |item|
      if [@key[:A1], @key[:A2], @key[:A3]].uniq.eql?([item])
        output.push(true, @key[:A1])
        break
      elsif [@key[:B1], @key[:B2], @key[:B3]].uniq.eql?([item])
        output.push(true, @key[:B1])
        break
      elsif [@key[:C1], @key[:C2], @key[:C3]].uniq.eql?([item])
        output.push(true, @key[:C1])
        break
      elsif [@key[:A1], @key[:B1], @key[:C1]].uniq.eql?([item])
        output.push(true, @key[:A1])
        break
      elsif [@key[:A2], @key[:B2], @key[:C2]].uniq.eql?([item])
        output.push(true, @key[:A2])
        break
      elsif [@key[:A3], @key[:B3], @key[:C3]].uniq.eql?([item])
        output.push(true, @key[:A3])
        break
      elsif [@key[:A1], @key[:B2], @key[:C3]].uniq.eql?([item])
        output.push(true, @key[:A1])
        break
      elsif [@key[:A3], @key[:B2], @key[:C1]].uniq.eql?([item])
        output.push(true, @key[:A3])
        break
      end
    end
    output
  end
end

# rubocop: enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
