require 'spec_helper'
require 'pry'

describe "TicTacToe" do
  describe "#initialize" do
    let(:game) { TicTacToe.new }
    it "initiates a class with a board with is an array of three arrays" do
      expect(game.board).to eq([["1","2","3"],["4","5","6"],["7","8","9"]])
    end
    it "has a writer method for board" do
      game.board[0][0] = "X"
      expect(game.board).to eq([["X","2","3"],["4","5","6"],["7","8","9"]])
    end
    it "initiates a class with a with a turn number of 0" do
      expect(game.turn_num).to eq(0)
    end
    it "has a writer method for turn number" do
      original_num = game.turn_num
      game.turn_num += 1
      expect(game.turn_num).to eq(original_num + 1)
    end
  end

  describe "#get_free_spaces" do
    let(:game) { TicTacToe.new }
    let(:tie_game) { 
      t       = TicTacToe.new
      t.board = [["O","O","X"],["X","O","O"],["O","X","X"]] 
      t
    }
    it "returns array that contains arrays of of all empty space coordinates at beginning of game" do
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
    it "returns array that contains arrays of of all empty space coordinates throughout game" do
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
    it "returns false when there is a winner" do
      game.board = [["X","X","X"],["O","O","X"],["O","X","O"]]
      expect(game.tie?).to eq(false)
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
    it "returns true for horizontal winner" do
      game.board = [["X","X","X"],["4","5","6"],["O","8","O"]]
      expect(game.winner?).to eq(true)
    end  
    it "returns true for vertical winner" do
      game.board = [["X","2","3"],["X","O","6"],["X","O","9"]]
      expect(game.winner?).to eq(true)
    end
  end
 
  describe "#message" do 
    let(:game) { TicTacToe.new }
    it "returns 'play' on if there is a no winner and no tie" do
      expect(game.message).to eq("play on")
    end
    it "returns 'tie' if there is a tie" do
      game.board = [["O","X","X"],["X","O","O"],["X","O","X"]]
      expect(game.message).to eq("tie")
    end
    it "returns 'win' if there is a winner" do
      game.board = [["X","X","X"],["4","5","6"],["O","8","O"]]
      expect(game.message).to eq("win")
    end 
  end

  describe "#user_move" do
    let(:game) { TicTacToe.new }
    it "takes coordinates (presented in a string of an array) and updates the board" do
      game.user_move("[0,2]")
      expect(game.board).to eq([["1","2","O"],["4","5","6"],["7","8","9"]])
      game.user_move("[0,0]")
      expect(game.board).to eq([["O","2","O"],["4","5","6"],["7","8","9"]])
    end
    it "updates the turn number" do
      original_num = game.turn_num
      game.user_move("[0,2]")
      expect(game.turn_num).to eq(original_num + 1)
    end
  end

  describe "#computer_move" do
    let(:game) { TicTacToe.new }
    it "plays in the center when user's first move is a corner" do
      game.board = [["O","2","3"],["4","5","6"],["7","8","9"]]
      game.computer_move
      expect(game.board).to eq([["O","2","3"],["4","X","6"],["7","8","9"]])
    end
    it "plays in any corner when user's first move is the center" do
      game.board = [["1","2","3"],["4","O","6"],["7","8","9"]]
      game.computer_move
      expect(game.board).to eq(
        [["X","2","3"],["4","O","6"],["7","8","9"]] || 
        [["1","2","X"],["4","O","6"],["7","8","9"]] ||
        [["1","2","3"],["4","O","6"],["X","8","9"]] ||
        [["1","2","3"],["4","O","6"],["7","8","X"]] 
      )
    end
    it "blocks the user from winning" do
      game.board = [["1","X","3"],["4","5","6"],["7","O","O"]]
      game.computer_move
      expect(game.board).to eq([["1","X","3"],["4","5","6"],["X","O","O"]])
    end
    it "completes a horizontal win" do
      game.board = [["X","X","3"],["O","O","6"],["X","O","O"]]
      game.computer_move
      expect(game.board).to eq([["X","X","X"],["O","O","6"],["X","O","O"]])
    end
    it "completes a vertical win" do
      game.board = [["X","X","O"],["4","O","6"],["X","O","O"]]
      game.computer_move
      expect(game.board).to eq([["X","X","O"],["X","O","6"],["X","O","O"]])
    end
    it "completes a diagonal win" do
      game.board = [["X","O","X"],["O","5","O"],["X","8","O"]]
      game.computer_move
      expect(game.board).to eq([["X","O","X"],["O","X","O"],["X","8","O"]])
    end
    it "prioritizes winning over blocking" do
      game.board = [["O","X","O"],["O","X","O"],["7","8","X"]]
      game.computer_move
      expect(game.board).to eq([["O","X","O"],["O","X","O"],["7","X","X"]])
    end
  end

end
