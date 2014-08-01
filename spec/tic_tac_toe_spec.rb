require 'spec_helper'
require 'pry'

describe "TicTacToe" do

  describe "#get_free_spaces" do
    let(:game) { TicTacToe.new }
    let(:tie_game) { 
      t       = TicTacToe.new
      t.board = [["O","O","X"],["X","O","O"],["O","X","X"]] 
      t
    }
    it "knows about all empty space coordinates at beginning of game" do
      expect(game.get_free_spaces).to include([0,0])
      expect(game.get_free_spaces).to include([1,0])
      expect(game.get_free_spaces).to include([2,0])
      expect(game.get_free_spaces).to include([0,1])
      expect(game.get_free_spaces).to include([1,1])
      expect(game.get_free_spaces).to include([2,1])
      expect(game.get_free_spaces).to include([0,2])
      expect(game.get_free_spaces).to include([1,2])
      expect(game.get_free_spaces).to include([2,2])
    end
    it "knows about all empty spaces throughout game" do
      game.board = [["1","2","X"],["O","X","6"],["7","X","O"]]
      expect(game.get_free_spaces).to include([0,0])
      expect(game.get_free_spaces).to include([0,1])
      expect(game.get_free_spaces).to include([1,2])
      expect(game.get_free_spaces).to include([2,0])
    end
    it "returns an empty array when there are no free spaces" do
      expect(tie_game.get_free_spaces).to eq([])
    end
  end

  describe "#free_space?" do 
    let(:game) { TicTacToe.new }
    it "returns true when the game starts" do
      expect(game.free_space?).to eq(true)
    end
    it "returns true when there are spaces available" do
      game.board = [["1","2","X"],["O","X","6"],["7","X","O"]]
      expect(game.free_space?).to eq(true)
    end  
    it "returns false when the spaces are filled" do
      game.board = [["O","O","X"],["X","O","O"],["O","X","X"]]
      expect(game.free_space?).to eq(false)
    end
  end

  describe "#tie?" do 
    let(:game) { TicTacToe.new }
    it "returns false when the game starts" do
      expect(game.tie?).to eq(false)
    end
    it "returns false when there are spaces available" do
      game.board = [["1","2","X"],["O","X","6"],["7","X","O"]]
      expect(game.tie?).to eq(false)
    end  
    it "returns true when the spaces are filled and there are no winners" do
      game.board = [["O","X","X"],["X","O","O"],["X","O","X"]]
      expect(game.tie?).to eq(true)
    end
  end

  describe "#winner?" do 
    let(:game) { TicTacToe.new }
    it "returns false for no winner" do
      expect(game.winner?).to eq(false)
      game.board = [["O","X","X"],["X","O","O"],["X","O","X"]]
      expect(game.winner?).to eq(false)
    end
    it "returns true when there is a diagonal winner" do
      game.board = [["X","X","O"],["O","X","O"],["X","O","X"]]
      expect(game.winner?).to eq(true)
    end
    it "returns false for horizontal winner" do
      game.board = [["X","X","X"],["4","5","6"],["O","8","O"]]
      expect(game.winner?).to eq(true)
    end  
    it "returns true for vertical winner" do
      game.board = [["X","2","3"],["X","O","6"],["X","O","9"]]
      expect(game.winner?).to eq(true)
    end
  end

end
