class Board
  attr_accessor :number_of_rows, :number_of_columns, :number_to_win, :game_condition

  def initialize(number_of_rows, number_of_columns)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @game_condition = "active"
    @number_to_win = 0
  end

  def create_board(rows,columns,board)
    board = Board.new(rows ,columns)
    board.puts_display
  end
  

  def game_array 
    Array.new(@number_of_rows).map do |row|
      Array.new(@number_of_columns)
    end
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

  def cell_selection(symbol)
    puts "What cell would you like to put your symbol?"

    response = $stdin.gets.chomp.split('')
    if response.length >= 3
     response[1] = response [1] + response[2]
    end

    until (response[0].ord >= 65 && response[0].ord <= 90) ||
      (response[0].ord >= 97 && response[0].ord <= 120)
      puts "Sorry, that's not a valid option for the row"
      reponse = $stdin.gets.chomp.split(' ')
    end

    base = @number_of_rows - 1 + 65 #67 C
    update_row = response[0].ord
    update_column = response[1].to_i - 1

    if (update_row >= 97 && update_row <= 120)
      update_row = update_row - 32 # "a" = 97 - 32 = 65
    end

    if update_row <= base
      update_row = base - update_row  

      if board[update_row][update_column] == nil
        update_method(update_row, update_column, symbol)
       
      else
        puts "#{response[0]}#{response[1]} is taken"
        cell_selection(symbol)
      end

    elsif (update_row > base) || (update_column > @number_of_columns)
      puts "There is no #{response[0]}#{response[1]} on this board, please try again"
      cell_selection(symbol)
    end
    
   
  end

 # recent_move = Cell.new(update_row, update_column, board)

        # if recent_move.won? 
        #   @game_condition = "done"
        # end


  def update_method(row, column, symbol)
    board[row][column] = symbol
  end

  def tie_check
    @board.each do |rows|
      if rows.all? {|cell| cell != nil}
        @game_condition = "tie"
      end
    end
  end

  # def update(row, column, symbol)
  #   base = @number_of_rows - 1 + 65 # 67 for C/ 72

  #   number_row = row.ord
  #   update_column = column - 1

  #   if (number_row >= 65 && number_row <= 90)
  #     number_row #A = 65
  #   elsif (number_row >= 97 && number_row <= 120)
  #     number_row = number_row - 32 # "a" = 97 - 32 = 65
  #   else
  #     number_row = nil
  #   end

  #   if number_row <= base
  #     update_row = base - number_row #67 - 65  = 2 72-65 = 7

  #     if board[update_row][update_column] == nil
  #       board[update_row][update_column] = symbol
  #     else
  #       puts "#{row}#{update_column} is taken"
  #     end

  #   elsif (number_row > base) || (update_column > @number_of_columns)
  #     puts "There is no #{row}#{update_column} on this board, please try again"
  #   end

  #   if @board.none? {|cell| cell = nil}
  #     @game_condition = "tie"
  #   end
    
  # end
  
  def requested_rows
    puts "How many rows would you like? (There's a minimum of three and maximum of 26)"
  
    rows = gets.chomp.to_i
  
    until (rows >= 3 && rows <= 26) && rows.integer?
      puts "Please enter a number that's greater than or equal to 3 and less than or equal to 26"
      rows = gets.chomp.to_i
    end

    rows
  end

  def requested_columns
    puts "How many columns would you like? (There's a minimum of three and maximum of 99)"
  
    columns = gets.chomp.to_i
  
    until (columns >= 3 && columns <= 99) && columns.integer?
      puts "Please enter a nubmer greater than or equal to 3 and less than or equal to 99"
      columns = gets.chomp.to_i
    end

    columns
  end

 

end

# game = Board.new(8,8)
# game.game_array
# game.cell_selection("X")
# p game.board[6][7]



# game.update("A",1,"X")
# game.update("F",5,"X")
# game.puts_display
# game.update("L",5,"X")

