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
    # [nil,nil,nil]]  (2,0) (A,0) 
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

  def update(row, column, player_name)
    base = @number_of_rows - 1 + 65 # 67 for C

    letter_row = row.ord # "A".ord 65 

    if (letter_row >= 65 && letter_row <= 90) && (letter_row < base)
      update_row = base - letter_row #67 - 65  = 2 
    elsif (letter_row >= 97 || letter_row <= 120)
      update_row = letter_row - 32  #97 - 67 - 32
   
    @board[]
    # Update logic to how to make changes to game array! 
  end

end

# game = Board.new(8,8)
# game.game_array

# game.puts_display

