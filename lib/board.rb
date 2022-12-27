class Board
  attr_accessor :rows, :columns, :number_of_rows, :number_of_columns

  def initialize(number_of_rows, number_of_columns)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @game_condition = 1
  end

  def game_array 
    Array.new(@number_of_rows).map do |row|
      Array.new(@number_of_columns)
    end

    # if 3 rows and 3 colummns
    # [nil,nil,nil]
    # [[nil,nil,nil], (0,0) (C,0) board.length = 3 65 + (board.length)3 - 1 67
    # base = C.ord
    # next is 
    # [nil,nil,nil],  (1,0) (B,0) 66
    # [nil,nil,nil]]  (2,0) (A,0) (A,1)
  end

  def board
    @board ||= game_array
  end

  def display
    number = 1
    starting_letter = 65 + (@number_of_rows - 1)


    rows = board.map do |row|
      number -= 1
     (starting_letter + number).chr + '|' + row.map do |cell| 

        if cell == nil
          cell = ' '
        else
          cell
        end
      end.join('|') + "|"
    end

   number_row = '  ' + 
      Array.new(@number_of_columns).map.with_index {|_, i| i +1}.join(' ') + " \n"

    (rows + [number_row]).join("\n")
  end

  def puts_display
    puts display
  end

  def update(row, column, symbol)
    base = @number_of_rows - 1 + 65 # 67 for C/ 72

    number_row = row.ord
    update_column = column - 1

    if (number_row >= 65 && number_row <= 90)
      number_row #A = 65
    elsif (number_row >= 97 && number_row <= 120)
      number_row = number_row - 32 # "a" = 97 - 32 = 65
    else
      number_row = nil
    end

    if number_row <= base
      update_row = base - number_row #67 - 65  = 2 72-65 = 7

      if board[update_row][update_column] == nil
        board[update_row][update_column] = symbol
      else
        puts "#{row}#{update_column} is taken"
      end

    elsif (number_row > base) || (update_column > @number_of_columns)
      puts "There is no #{row}#{update_column} on this board, please try again"
    end
    
   

  end
  

end

game = Board.new(8,8)
game.game_array

game.update("A",1,"X")
game.update("F",5,"X")
game.puts_display
game.update("L",5,"X")

