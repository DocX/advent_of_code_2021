require 'set'

class Board
  def self.parse_boards(lines)
    lines.each_slice(6).map do |board_lines|
      Board.parse_board(board_lines)
    end
  end

  def self.parse_board(lines)
    rows = lines.reject{ |line| line.strip.empty? }.map do |line|
      line.split.map(&:to_i)
    end

    Board.new(rows)
  end

  attr_reader :marked

  def initialize(rows)
    @rows = rows
    @marked = Set.new
  end

  def mark(number)
    @marked << number
  end

  def winning?
    marked_row? || marked_col?
  end

  def marked_row?
    @rows.any? { |row| row.all? { |number| @marked.include? number } }
  end

  def marked_col?
    @rows[0].each_with_index.any? do |_, col_index|
      @rows.all? { |row| @marked.include? row[col_index] }
    end
  end

  def to_s
    @rows.map { |row| row.map { |number| "#{@marked.include?(number) ? "*" : ""}#{number}".rjust(3) }.join(" ") }.join("\n")
  end

  def sum_unmarked
    @rows.flat_map { |row| row }.reject { |number| @marked.include? number}.sum
  end
end

def play_bingo(boards, numbers_to_draw)
  numbers_to_draw.each do |number|
    boards.each { |board| board.mark number }

    winning_boards = boards.select(&:winning?)
    yield [number, winning_boards[0]] if winning_boards.size > 0
    
    boards = boards.reject(&:winning?)
  end
end

def first_winning_board(boards, numbers_to_draw)
  play_bingo(boards, numbers_to_draw) do |number, winning_board|
    return [number, winning_board]
  end
end

def last_winning_board(boards, numbers_to_draw)
  last = nil
  play_bingo(boards, numbers_to_draw) do |number, winning_board|
    last = [number, winning_board]
  end

  return last
end


lines = File.readlines(ARGV[0])
numbers_to_draw = lines[0].split(",").map(&:to_i)
boards_lines = lines[2..-1]

boards = Board.parse_boards(boards_lines)
winning_number, winning_board = first_winning_board(boards, numbers_to_draw)
puts "first winning number: #{winning_number}"
puts "first winning board:\n#{winning_board}"
puts "first sum unmarked: #{winning_board.sum_unmarked}"
puts "first score: #{winning_board.sum_unmarked * winning_number}"
puts ""

boards = Board.parse_boards(boards_lines)
winning_number, winning_board = last_winning_board(boards, numbers_to_draw)
puts "last winning number: #{winning_number}"
puts "last winning board:\n#{winning_board}"
puts "last sum unmarked: #{winning_board.sum_unmarked}"
puts "last score: #{winning_board.sum_unmarked * winning_number}"