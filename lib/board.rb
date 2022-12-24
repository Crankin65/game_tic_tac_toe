class Board
  attr_accessor :rows, :columns, :number_of_rows, :number_of_columns

  def initialize(number_of_rows, number_of_columns)
    @number_of_rows = number_of_rows
    @number_of_columns = @number_of_columns
    @game_condition = 1
  end

  def game_array 
    Array.new(@number_of_rows).map do |row|
      Array.new(@number_of_columns)
    end

    # if 3 rows and 3 colummns
    # [nil,nil,nil]
    # [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  end

  def board
    @board ||= rows
  end

  
end