class TicTacToe

  attr_accessor :board, :turn_num

  def initialize
    @board = [["1","2","3"],["4","5","6"],["7","8","9"]]
    @turn_num = 0
  end

  def message
    if winner?
      "win"
    elsif tie?
      "tie"
    else
      "play on"
    end
  end
 
  def user_move(space)
    row = space[1].to_i
    column = space[3].to_i
    update_board(row, column, "O")
  end

  def computer_move
    _, next_move = minimax(self.board, -1)
    row, column = next_move
    update_board(row, column, "X")
  end

  def update_board(row, column, string)
    self.turn_num += 1
    self.board[row][column] = string
  end

  def free_space?
    if get_free_spaces.empty?
      return false
    else
      return true
    end
  end

  def get_free_spaces(b=self.board)
    spaces = []
    b.each_with_index do |row, row_index|
      row.each_with_index do |space, column_index|
        if space != "O" && space != "X"
          spaces << [row_index, column_index]
        end
      end
    end
    spaces
  end

def minimax(board, number)
    move_winners = []
    get_free_spaces(board).each do |row, column|
      player = number == -1 ? "X" : "O"
      original_piece = board[row][column]
      board[row][column] = player
      if winner?(board)
        winner = number
      elsif get_free_spaces(board).empty?
        winner = 0
      else
        winner, _ = minimax(board, -number)
      end
      move_winners << [winner, [row, column]]
      board[row][column] = original_piece
    end

    if number == 1
      return move_winners.max
    else
      return move_winners.min
    end
  end

  def tie?
    if get_free_spaces.length < 1
      return true if winner? == false
    end
    false
  end

  def winner?(b=self.board)
    return diagonal_winner?(b) || horizontal_winner?(b) || vertical_winner?(b)
  end

  def diagonal_winner?(board)
    middle = board[1][1]
    diag_1 = board[0][0] == middle && middle == board[2][2]
    diag_2 = board[0][2] == middle && middle == board[2][0] 
    return diag_1 || diag_2
  end

  def horizontal_winner?(board)
    row = 0
    while row < 3
      middle = board[row][1]
      if board[row][0] == middle && middle == board[row][2] 
        return true
      end
      row += 1
    end
    return false
  end

  def vertical_winner?(board)
    column = 0
    while column < 3
      middle = board[1][column]
      if board[0][column] == middle && middle == board[2][column]
        return true
      end
      column += 1
    end
    return false
  end
end