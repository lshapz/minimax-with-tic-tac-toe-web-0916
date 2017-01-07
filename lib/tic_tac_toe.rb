require 'byebug'
    require 'json'

class TicTacToe
  attr_accessor :board, :turn_num

  def initialize
    self.board = [["1","2","3"],["4","5","6"],["7","8","9"]]
    self.turn_num = 0 
  end

  def get_free_spaces(my_board = self.board)
    space_array = []
    my_board.each.with_index do |sub_array, index1|
      sub_array.each.with_index do |position, index2|
        if position != "O" && position != "X"
          space_array << [index1, index2]
        end
      end
    end
    space_array 
  end

  def free_space?
    if self.get_free_spaces == []
      return false
    else
      return true
    end
  end

WIN_COMBINATIONS = [
    [0,4,8],
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [6,4,2]
  ]

  def win_positions(board=self.board)
    winning = WIN_COMBINATIONS.map do |win_arrays|
      win_arrays.map do |y|
       board.flatten[y]
      end
    end 
  end

  def winner?(board=self.board)
    if win_positions(board).include?(["X", "X", "X"])
      return true 
    elsif win_positions(board).include?(["O", "O", "O"])
      return true
    else
      return false
    end
  end

  def tie?
    if !self.free_space? && !self.winner? 
      return true
    else
      return false
    end
  end

  def message 
    if !self.tie? && !self.winner?
      return "play on"
    elsif self.tie? 
      return "tie"
    else self.winner?
      return "win" 
    end
  end

  def user_move(input_string)
    #  = [[input_string[1], input_string[3]]
    input_array= JSON.parse(input_string)
    row, column = input_array
    # same as row = input_array[0], column = input_array[1]
    if self.get_free_spaces.include?(input_array.to_a)
      self.board[row][column] = "O"
      self.turn_num += 1
    end
  end


  def computer_move
    _player, move = minimax(self.board, -1)
    row, column = move 
    # same as row = move[0], column = move[1]
    self.board[row][column] = "X"
    self.turn_num += 1 
  end

def minimax(board, id)
    move_winners = []

    get_free_spaces(board).each do |row, column|
      player = (id == -1 ? "X" : "O")
    # -1 is computer, 1 is human 
      try_position = board[row][column]
    # saves the original value for resetting board at end of attempt?
    # selects each possiblity 
      board[row][column] = player
    # inserts the current player's piece in there to see how that looks 

      if winner?(board)
        winner = id
      elsif get_free_spaces(board).empty?
        winner = 0
    # doesn't use tie? because that doesn't take a param and this is easier
      else
        winner, _move = minimax(board, -id)
    # return formatted like [1, [1, 1]] 
      end

  # if game over (win or tie) declares a winner 
  # else recursively runs  algorithm again moving down tree 
  # it runs through human too it -- basically plays the whole game 
      move_winners << [winner, [row, column]]
      # pushes result of move tree into the array
      board[row][column] = try_position
      # resets the board
    end

    if id == 1
      return move_winners.max
    else
      return move_winners.min
    end

  end

end