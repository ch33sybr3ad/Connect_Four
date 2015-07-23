require "awesome_print"

## Connect Four Models ## 

class Cell
  attr_accessor :player_value, :index, :row, :column
  # cell class contains player_value, cell index, row and column
  def initialize(index,b_rows,b_columns)
    @player_value = 0
    @index = index
    @row = index/b_columns
    @column = index%b_columns
  end
end

class Game
  attr_reader :board, :game_over
  # initilizes board as array with 42 indexed cell objects
  def initialize(row,column)
    @row = row
    @column = column
    @board = ("0"*@row*@column).chars.each_with_index.map { |char, index| Cell.new(index,row,column)}
    @game_over = false
  end

  #prints board for different non-regular board size
  def print_board
    new_board = @board.map { |cell| cell = cell.player_value}
    new_board.each_slice(@column).to_a.each { |row| p row }
  end

  # method prints board nicely in console (normal 6x7 board only)
  def to_s
        string = <<-BOARD
    Jason's Connect Four!!
      +-------+-------+
      | 0 1 2 3 4 5 6 |
      +-------+-------+
      | X X X X X X X |
      | X X X X X X X |
      | X X X X X X X |
      | X X X X X X X |
      | X X X X X X X |
      | X X X X X X X |
      +-------+-------+
      BOARD
    @board.each { |cell|
      display = cell.player_value || " "
      string.sub!(/X/, display.to_s)
    }
    string
  end

  # allows player to make a move
  def move(player_value, column)
    # returns array with cell objects in the same column
    column_array = @board.map.with_index { |cell, index| @board.slice(index,1) if (cell.column == column) }.compact.flatten

    # contains last modified cell
    last_move = nil

    # reverse column and "drops" the connect four piece
    column_array.reverse.each do |cell|
      next if cell.player_value > 0 
      cell.player_value = player_value
      last_move = cell
      break
    end

    # checks to see if last move was winning move
    check_win_condition(last_move, column_array)
  end

  def check_win_condition(cell, column_array)
    check_row(cell) || check_column(column_array) || check_right_diagonal(cell) || check_left_diagonal(cell)
  end

  def check_row(last_move_cell)
    # retrieves row of last_move
    row_array = @board.map.with_index { |cell, index| @board.slice(index,1) if (cell.row == last_move_cell.row) }.compact.flatten
    
    scan_array_for_winner(row_array)
  end

  def check_column(column_array)
    scan_array_for_winner(column_array)
  end

  # checks the right diagonal \
  def check_right_diagonal(cell)
    # cannot win if diagonal is not long enough
    return false if cell.row >= 3 
    return false if (@column-1-cell.column) <=3

    # returns right diagonal from last move
    right_diagonal_array = Array.new(4).map.with_index do |value, index| 
      value = @board[cell.index + index * 8]
    end

    scan_array_for_winner(right_diagonal_array)
  end

  # checks the left diagonal /
  def check_left_diagonal(cell)
    # cannot win if diagonal is not long enough
    return false if cell.row >= 3 
    return false if (cell.column) <=2
    
    # returns left diagonal from last move
    left_diagonal_array = Array.new(4).map.with_index do |value, index| 
      value = @board[cell.index + index * 6]
    end

    scan_array_for_winner(left_diagonal_array)
  end

  # ends the game and declares a winner
  def end_game
    if @game_over
      puts "CONGRATULATIONS PLAYER #{@game_over} HAS WON THE GAME"
      sleep(2)
    end
  end

  def scan_array_for_winner(array)
    # checks to see if first player won
    if /1{4}/ === array.map(&:player_value).join
      @game_over = 1
    end

    # checks to see if second player won
    if /2{4}/ === array.map(&:player_value).join
      @game_over = 2
    end
    
    #announces winner of game and ends game
    end_game
  end
end


