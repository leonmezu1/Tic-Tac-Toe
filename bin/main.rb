#!/usr/bin/env ruby
# frozen_string_literal: true

p "Welcome to Tic-Tac-Toe, Let's Game"
p "Type 'I' for instructions and learn how to play"
p "Type 'X' to start!"

start_key = gets.chomp

case start_key
when 'I'
	p `clear`
	p 'This are the instructions to play'
when 'X'
	p `clear`
	p "Let's play"
else
	"Invalid input, press any key to try again!"
end