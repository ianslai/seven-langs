require 'pp'

BOARD_SIZE = 4
CONSUMED = '_'

class BoggleBoard

  attr_reader :trail

  def initialize(board_arr, trail=[])
    @board = board_arr
    @trail = trail
  end

  def index(x, y)
    x + y * BOARD_SIZE
  end

  def at(x, y)
    @board[index(x, y)]
  end

  def consume(x, y)
    new_board = Array.new(@board)
    new_board[index(x, y)] = CONSUMED
    BoggleBoard.new(new_board, @trail + [[x, y]])
  end

  def neighbors(x, y)
    [
      [x - 1, y],
      [x + 1, y],
      [x, y - 1],
      [x, y + 1],
    ].select do |nx, ny|
      nx >= 0 && ny >= 0 && nx < BOARD_SIZE && ny < BOARD_SIZE
    end
  end

  def find(str)
    indexes = (0..(BOARD_SIZE - 1)).to_a
    indexes.product(indexes).reduce(nil) do |found, pos|
      found || find_substring(str, pos.first, pos.last)
    end
  end

  def find_substring(str, x, y)
    return self if str.empty?
    letter = str[0..0]
    return nil if letter != at(x, y)
    remainder = str[1..-1]
    new_board = consume(x, y)
    new_board.neighbors(x, y).reduce(nil) do |found, pos|
      found || new_board.find_substring(remainder, pos.first, pos.last)
    end
  end

  def to_s
    board = @board.each_slice(4).map {|letters| letters.join('')}.join("\n")
    "Board:\n#{board}\nWord trail: #{trail}"
  end
end



def main
  found = BoggleBoard.new('ABCDABAZAOGGAAEL'.split('')).find('BOGGLE')
  if found
    puts found
  else
    puts "The word was not found in the Boggle board"
  end
end

main
