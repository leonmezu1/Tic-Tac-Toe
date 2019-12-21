#!/usr/bin/env ruby
# frozen_string_literal: true

# executability tested

require_relative 'game_engine'

class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
