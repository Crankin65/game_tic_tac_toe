require './lib/InputPrompt'

class Board
  attr_reader :number_of_rows, :number_of_columns
  attr_accessor :number_to_win, :game_condition

  def initialize(number_of_rows, number_of_columns)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @game_condition = 'active'
    @number_to_win = 0
  end

  def board
    @board ||= game_array
  end

  def puts_display
    puts display
  end

  def row_selection(row)
    if (row.ord >= 65 && row.ord <= 90) || (row.ord >= 97 && row.ord <= 122)
      base = @number_of_rows - 1 + 65
      update_row = row.ord

      if update_row >= 97 && update_row <= 120
        update_row -= 32
      end

      if update_row <= base
        base - update_row
      else
        false
      end

    else
      false
    end
  end

  def column_selection(column)
    if column.to_i.zero?
      update_column = column.to_i - 1

      if (update_column <= @number_of_columns - 1) && (update_column >= 0)
        update_column
      else
        false
      end

    end

  end

  def update_check(row, column)
    if board[row][column].nil?
      true
    else
      puts 'That cell is taken'
      false
    end
  end

  def cell_selection
    response = InputPrompt.ask('What cell would you like to put your symbol?').split('')

    if response.length >= 3
      response[1] = response[1] + response[2]
    elsif response.length <= 1
      puts 'Please enter an available cell'
      cell_selection
    end

    response
  end

  def update(row, column, symbol)
    board[row][column] = symbol
  end

  def tie_check
    @board.each do |rows|
      @game_condition = 'tie' if rows.all? { |cell| !cell.nil? }
    end
  end

  def requested_rows
    rows = InputPrompt.ask("How many rows would you like? (There's a minimum of 3 and maximum of 26)").to_i

    until rows >= 3 && rows <= 26
      rows = InputPrompt.ask("Please enter a number that's greater than or equal to 3 and less than or equal to 26").to_i
    end

    rows
  end

  def requested_columns
    puts "How many columns would you like? (There's a minimum of 3 and maximum of 99)"
    columns = gets.chomp.to_i

    until columns >= 3 && columns <= 99 # && columns.integer?
      puts 'Please enter a number greater than or equal to 3 and less than or equal to 99'
      columns = gets.chomp.to_i
    end

    columns
  end

  private

  def game_array
    Array.new(@number_of_rows).map do |_row|
      Array.new(@number_of_columns)
    end
  end

  def display
    number = 1
    starting_letter = 65 + (@number_of_rows - 1)

    rows = board.map do |row|
      number -= 1
      (starting_letter + number).chr + '|' + row.map do |cell|
        if cell.nil?
          cell = ' '
        else
          cell
        end
      end.join('|') + '|'
    end

    number_row = '  ' +
      Array.new(@number_of_columns).map.with_index { |_, i| i + 1 }.join(' ') + " \n"
    (rows + [number_row]).join("\n")
  end

end

