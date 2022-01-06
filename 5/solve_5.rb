class Line
  def self.parse(line)
    xy1, xy2 = line.split("->").map(&:strip)
    x1, y1 = xy1.split(",").map(&:to_i)
    x2, y2 = xy2.split(",").map(&:to_i)

    Line.new(x1, y1, x2, y2)
  end

  attr_reader :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def aligned?
    horizontal? || vertical?
  end

  def horizontal?
    y1 == y2
  end

  def vertical?
    x1 == x2
  end

  def diagonal?
    (x1 - x2).abs == (y1 - y2).abs
  end

  def x_range
    (x1 .. x2).step(x1 >= x2 ? -1 : 1).entries
  end

  def y_range
    (y1 .. y2).step(y1 >= y2 ? -1 : 1).entries
  end

  def points
    return x_range.map { |x| [x, y1] } if horizontal?
    return y_range.map { |y| [x1, y] } if vertical?
    return x_range.zip(y_range) if diagonal?

    raise "Unsupported line"
  end
end

def parse_lines(input)
  input.map { |line| Line.parse(line) }
end

def overlaps(lines)
  lines.flat_map(&:points).tally
end

def count_of_overlaps(lines, threshold)
  overlaps(lines).count { |_, overlaps| overlaps >= threshold }
end

input = File.readlines(ARGV[0])
lines = parse_lines(input)

puts "number of overlaps for horizontal/vertical lines >= 2: #{count_of_overlaps(lines.select(&:aligned?), 2)}"
puts "number of overlaps for all lines >= 2: #{count_of_overlaps(lines, 2)}"