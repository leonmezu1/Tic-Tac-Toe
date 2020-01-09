# frozen_string_literal: true

require 'spec_helper.rb'
require './lib/game_engine.rb'
require './lib/player_engine.rb'

RSpec.describe 'Tic Tac Toe' do
  test_game = Game.new('test_session')
  test_board = Board.new

  let(:scenario0) { { A1: 'X', A2: 'X', A3: 'X', B1: 'O', B2: 'O', B3: '-', C1: '-', C2: '-', C3: '-' } }

  let(:scenario1) { { A1: 'X', A2: 'X', A3: 'O', B1: 'O', B2: 'X', B3: 'X', C1: 'X', C2: 'O', C3: 'O' } }

  describe '#mode_selector' do
    it "prints the game's selection mode" do
      expect(test_game.mode_selector.is_a?(Array)).to be true
    end
  end

  describe '#cl_screen' do
    it 'clears the console screen' do
      expect(test_game.cl_screen).to be_truthy
    end
  end

  describe '#game_promt' do
    it 'flashes a fancy ascii in the console a defined number of times' do
      expect(test_game.game_promt(1)).to be_truthy
    end
  end

  describe '#flash' do
    it 'flashes one or two string a defined number of times' do
      expect(test_game.flash('This is ', 'the string', 2)).to be_truthy
    end
  end

  describe '#hold' do
    it 'pauses the console with until a new keyboard input is detected' do
      expect(test_game.hold).to be_nil
    end
  end

  describe '#game_input' do
    it 'takes the user input' do
      expect(test_game.hold).to be_nil
    end
  end

  describe '#board' do
    it "prints the game's board when gaming" do
      expect(test_board.board.is_a?(Array)).to be true
    end
  end

  describe '#win_scenario' do
    it "outputs true if there's a winner and his/her input" do
      test_board.key = scenario0
      expect(test_board.win_scenario).to eq([true, 'X'])
    end

    it "outputs an empty array if there's no winner" do
      test_board.key = scenario1
      expect(test_board.win_scenario).to eq([])
    end
  end
end
