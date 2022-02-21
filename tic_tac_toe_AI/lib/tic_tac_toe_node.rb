require_relative 'tic_tac_toe'

# write a TicTacToeNode class which utilizes the Board class from the TTT solution.
# 


class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos =
    board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.

  # iterate through all positions that are empty? on the board object. For each empty position, create a node by duping the board and putting a next_mover_mark in the position. You'll want to alternate next_mover_mark so that next time the other player gets to move. Also, set prev_move_pos to the position you just marked, for reasons that will make sense when we use it later.

# intiailize node, dupe board + put next_mover_mark in that pos
# alternate next_mover_mark
# prev_move_pos = position just marked

  def children
    children = []

    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]

        next unless board.empty?(pos)

        new_board = board.dup
        new_board[pos] = self.next_mover_mark
        next_mover_mark = (self.next_mover_mark == :x ? :o : :x )

        children << TicTacToeNode.new(new_board, next_mover_mark, pos)
      end
    end

    children
  end
end
