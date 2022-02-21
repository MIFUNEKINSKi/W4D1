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
    if board.over?
      # Note that a loss in this case is explicitly the case where the
      # OTHER person wins: a draw is NOT a loss. Board#won? returns
      # false in the case of a draw.
      return board.won? && board.winner != evaluator
    end

     if self.next_mover_mark == evaluator
      # If it's the turn of the 'evaluator', and no matter where we
      # move the opponent can force a loss, then this is already a
      # lost node.
      self.children.all? { |node| node.losing_node?(evaluator) }
    else
      # If it's the opponent's turn, and they have any move where they
      # can eventually force a loss, we assume that the opponent play
      # perfectly and will take that move and eventually beat us.
      self.children.any? { |node| node.losing_node?(evaluator) }
    end

  end 

  def winning_node?(evaluator)
      if board.over?
      # Note that a loss in this case is explicitly the case where the
      # OTHER person wins: a draw is NOT a loss. Board#won? returns
      # false in the case of a draw.
      return board.winner == evaluator
    end
    
    if self.next_mover_mark == evaluator
      self.children.any? { |node| node.winning_node?(evaluator) }
    else
      self.children.all? { |node| node.winning_node?(evaluator) }
    end

    # if self.next_mover_mark = evaluator
    #   self.children.all? { |node| node.winning_node?(evaluator) }
    # end 
      
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
