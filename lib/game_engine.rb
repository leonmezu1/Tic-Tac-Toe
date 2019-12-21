#!/usr/bin/env ruby
# frozen_string_literal: true

# executability tested

# rubocop: disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity

require_relative 'player_engine'
require 'io/console'

class Game
  def initialize(session)
    @session = session
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
  def initialize
    @key = {
      A1: '-', A2: '-', A3: '-',
      B1: '-', B2: '-', B3: '-',
      C1: '-', C2: '-', C3: '-'
    }
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
