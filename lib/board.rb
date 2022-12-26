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
    # [[nil,nil,nil], (0,0)
    # [nil,nil,nil],  (1,0)
    # [nil,nil,nil]]  (2,0)
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

end

# game = Board.new(8,8)
# game.game_array

# game.puts_display

