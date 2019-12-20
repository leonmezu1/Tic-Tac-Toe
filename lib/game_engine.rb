#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'player_engine.rb'
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

  def board
    puts '|-------------------------------------|'
    puts '|-------------------------------------|'
    puts '|-------------------------------------|'
    puts '|                                     |'
    puts '|            | 1 | 2 | 3 |            |'
    puts '|          A | - | - | - |            |'
    puts '|          B | - | - | - |            |'
    puts '|          C | - | - | - |            |'
    puts '|                                     |'
    puts '|-------------------------------------|'
    puts '|-------------------------------------|'
    puts '|-------------------------------------|'
    puts ''
  end
end
