class Board
  attr_accessor :rows, :columns, :number_of_rows, :number_of_columns

  def initialize(number_of_rows, number_of_columns)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @game_condition = active
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

  def cell_selection 
    puts "What cell would you like to put your symbol?"

    

    until (response[0].ord >= 65 && response [0] <= 90) ||
      (response[0].ord >= 97 && response[0].ord <= 120)
      puts "Sorry, that's not a valid"
      reponse = $stdin.gets.chomp.split(' ')
    end

    base = @number_of_rows - 1 + 65
    update_row = response[0].ord
    update_column = response[1] - 1

    if (update_row >= 65 && update_row <= 90)
     update_row #A = 65
    elsif (update_row >= 97 && update_row <= 120)
      update_row = update_row - 32 # "a" = 97 - 32 = 65
    end

    if update_row <= base
      update_row = base - update_row

      if @board[update_row][update_column] == nil
        update_method(update_row, update_column, symbol)
      else
        puts "#{row}#{update_column} is taken"
        cell_selection
      end

    elsif (number_row > base) || (update_column > @number_of_columns)
      puts "There is no #{row}#{update_column} on this board, please try again"
      cell_selection
    end
    

  end


  def update_method(row,column,symbol)
    @board[row][column] = symbol
  end

  def tie_check
    if @board.none? {|cell| cell = nil}
      @game_condition = "tie"
    end
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

      if @board[update_row][update_column] == nil
        @board[update_row][update_column] = symbol
      else
        puts "#{row}#{update_column} is taken"
      end

    elsif (number_row > base) || (update_column > @number_of_columns)
      puts "There is no #{row}#{update_column} on this board, please try again"
    end

    if @board.none? {|cell| cell = nil}
      @game_condition = "tie"
    end
    
  end
  
  def requested_rows
    puts "How many rows would you like? (There's a minimum of three)"
  
    rows = gets.chomp.to_i
  
    until rows >= 3 && rows.integer?
      puts "Please enter a number that's greater than or equal to 3"
      rows = gets.chomp.to_i
    end

    rows
  end

  def requested_columns
    puts "How many columns would you like? (There's a minimum of three)"
  
    columns = gets.chomp.to_i
  
    until columns >= 3 && columns.integer?
      puts "Please enter a nubmer greater than or equal to 3"
      columns = gets.chomp.to_i
    end

    columns
  end

  def winning_condition
    puts "How many in a row will win the game? The minimum is 3. The maximum is the number of rows or columns you have (the highest of either)"

    $winning_conidition = gets.chomp.to_i

    until $winning_condition.integer? && ($winning_condition <= requested_columns || $winning_condition <= requested_rows) && $winning_condition >= 3
      $winning_condition
    else
      puts "Please put a number that is greater than 3, and less than or equal to the highest number (between rows or columns)"
    end
  end

  def create_board
    requested_rows
    requested_columns
    @game_board = Board.new(requested_rows ,requested_columns)
    @gameboard.puts_display
  end
  

end

game = Board.new(8,8)
game.game_array

game.update("A",1,"X")
game.update("F",5,"X")
game.puts_display
game.update("L",5,"X")

