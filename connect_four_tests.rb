require "rspec"
require_relative "connect_four_game"

## CONNECT FOUR TESTS ## 

RSpec.describe Cell do
  it "should create a new cell object" do
    test_cell = Cell.new(1,6,7)
    expect(test_cell.index).to eq(1)
    expect(test_cell.row).to eq(0)
    expect(test_cell.column).to eq(1)
    expect(test_cell.player_value).to eq(0)
  end

  it "should change value when player makes a move" do
    test_cell = Cell.new(1,6,7)
    expect(test_cell.player_value).to eq(0)
    test_cell.player_value = 1
    expect(test_cell.player_value).to eq(1)
  end
end

RSpec.describe Game do
  it "should create game with variable board sizes" do
    new_game = Game.new(6,7)
    expect(new_game.board.flatten.length).to eq(42)

    new_game2 = Game.new(4,4)
    expect(new_game2.board.flatten.length).to eq(16)
  end

  it "should drop piece to bottom of board on player move" do
    new_game = Game.new(6,7)
    new_game.move(1,6)

    last_move = new_game.board.flatten.find {|cell| cell.index == 41 }
    expect(last_move.player_value).to eq(1)
  end 

  it "should end the game when player wins" do
    new_game = Game.new(6,7)
    expect(new_game.board.flatten.length).to eq(42)

    new_game.move(1,6)
    new_game.move(1,6)
    new_game.move(1,6)
    new_game.move(1,6)

    expect(new_game.game_over).to eq(1)
  end
end