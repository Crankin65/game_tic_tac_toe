require './lib/board'

class Cell
  attr_reader :row, :column, :board, :vertical_neighbors, :horizontal_neighbors, :left_diagonal_neighbors, :right_diagonal_neighbors

  def initialize(row,column,board)
    @row = row
    @column = column
    @board = board
    @vertical_neighbors = 0
    @horizontal_neighbors = 0
    @left_diagonal_neighbors = 0
    @right_diagonal_neighbors = 0
  end

  def symbol
    @board[row][column]
  end

  def down
    if row < board.size - 1 #row 4, board.size = # of rows #a1 = 4,0
      Cell.new(row + 1, column, board) #create new cell directly below current cell
    end
  end

  def down_neighbor
    if down != nil #checks if cell below is not nil
      if down.symbol == symbol #checks if cell below == current cell that's being checked 
        return down
      end
    end
  end

  def down_neighbors
    @vertical_neighbors += if down_neighbor #if down neighbor is true, increase once, then check next down neighbor
      1 + down_neighbor.down_neighbors
    else
      0
    end
  end

  def up 
    if row >= 0  #row [6] size is 8
      Cell.new(row - 1, column, board)
    end
  end

  def up_neighbor
    if up != nil
      if up.symbol == symbol
        return up
      end
    end
  end

  def up_neighbors
    @vertical_neighbors += if up_neighbor
      1 + up_neighbor.up_neighbors
    else
      0
    end
  end

  def vertical_traversal
    down_neighbors
    up_neighbors
  end

  def left
    if column > 0 #0,0
      Cell.new(row, column - 1, board)
    end
  end

  def left_neighbor
    if left != nil
      if left.symbol == symbol
        return left
      end
    end
  end

  def left_neighbors
    @horizontal_neighbors += if left_neighbor
                              1 + left_neighbor.left_neighbors
                            else 
                              0
                            end
  end

  def right
    if column < board[0].size
     Cell.new(row, column + 1, board)
    end
  end

  def right_neighbor
    if right != nil  
      if right.symbol == symbol
        return right
      end
    end
  end

  def right_neighbors
    @horizontal_neighbors += if right_neighbor
                              1 + right_neighbor.right_neighbors
                            else 
                              0
                            end
  end

  def horizontal_traversal
    left_neighbors
    right_neighbors
  end

  def up_left
    if row > 0 && column > 0 
      Cell.new(row - 1,column - 1,board)
    end
  end

  def diagonal_up_left_neighbor
    if up_left != nil
      if up_left.symbol == symbol
        return up_left
      end
    end
  end

  def diagonal_up_left_neighbors
    @left_diagonal_neighbors += if diagonal_up_left_neighbor 
      1 + diagonal_up_left_neighbor.diagonal_up_left_neighbors
    else
      0
    end
  end

  def down_right
    if row < board.size - 1 && column < board[0].size
      Cell.new(row + 1,column + 1,board)
    end
  end

  def diagonal_down_right_neighbor
    if down_right != nil
      if down_right.symbol == symbol
        return down_right
      end
    end
  end

  def diagonal_down_right_neighbors
    @left_diagonal_neighbors += if diagonal_down_right_neighbor 
      1 + diagonal_down_right_neighbor.diagonal_down_right_neighbors
    else
      0
    end
  end

  def diagonal_left_traversal
    diagonal_up_left_neighbors
    diagonal_down_right_neighbors
  end

  def up_right
    if row > 0 && column < board[0].size 
      Cell.new(row - 1,column + 1,board)
    end
  end

  def diagonal_up_right_neighbor
    if up_right != nil
      if up_right.symbol == symbol
        return up_right
      end
    end
  end

  def diagonal_up_right_neighbors
    @right_diagonal_neighbors += if diagonal_up_right_neighbor 
      1 + diagonal_up_right_neighbor.diagonal_up_right_neighbors
    else
      0
    end
  end

  def down_left
    if row < board.size - 1 && column >= 0
      Cell.new(row + 1,column - 1,board)
    end
  end

  def diagonal_down_left_neighbor
    if down_left != nil
      if down_left.symbol == symbol
        return down_left
      end
    end
  end

  def diagonal_down_left_neighbors
    @right_diagonal_neighbors += if diagonal_down_left_neighbor 
      1 + diagonal_down_left_neighbor.diagonal_down_left_neighbors
    else
      0
    end
  end

  def diagonal_right_traversal
    diagonal_up_right_neighbors
    diagonal_down_left_neighbors
  end



  def won?(number_to_win)
    vertical_traversal
    horizontal_traversal
    diagonal_left_traversal
    diagonal_right_traversal

    return true if vertical_neighbors >= (number_to_win - 1)
    return true if horizontal_neighbors >= (number_to_win - 1 )
    return true if left_diagonal_neighbors >= (number_to_win - 1)
    return true if right_diagonal_neighbors >= (number_to_win - 1)
   
    false
  end
end