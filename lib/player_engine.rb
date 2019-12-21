#!/usr/bin/env ruby
# frozen_string_literal: true

class Player
  def initialize(name)
    @name = name
  end

  class << self
    attr_accessor :name
    end
end
