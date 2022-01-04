def line_bits(line)
  line.strip.chars.map { |c| c.to_i }
end

def count_bits_of_one(lines)
  lines.reduce(nil) do |ones_count, line|
    next line_bits(line) if ones_count.nil?

    ones_count.zip(line_bits(line)).map { |a, b| a + b }
  end
end

def most_common_bit_sum(lines, bit_when_one, bit_when_zero)
  half_count = lines.count / 2

  # most common bits
  count_bits_of_one(lines)
    .map { |ones| ones >= half_count ? bit_when_one : bit_when_zero }
    .join("")
    .to_i(2)
end

def gamma_rate(lines)
  most_common_bit_sum(lines, 1, 0)
end

def epsilon_rate(lines)
  most_common_bit_sum(lines, 0, 1)
end

def most_common_position_filter(lines, keep_when_one, keep_when_zero, position = 0)
  # determine the most common value (0 or 1) in the current bit position, 
  # and keep only numbers with that bit in that position. 
  # If 0 and 1 are equally common, keep values with a 1 in the position being considered.
  
  position_count_of_ones = count_bits_of_one(lines)[position]
  keep_value = position_count_of_ones >= (lines.count - position_count_of_ones) ? keep_when_one : keep_when_zero

  filtered_lines = lines.select { |line| line_bits(line)[position] == keep_value }
  return most_common_position_filter(filtered_lines, keep_when_one, keep_when_zero, position + 1,) if filtered_lines.size > 1

  filtered_lines[0].to_i(2)
end

def oxygen_rating(lines)
  most_common_position_filter(lines, 1, 0)
end

def co2_rating(lines)
  most_common_position_filter(lines, 0, 1)
end

lines = File.readlines(ARGV[0])

puts "gamma rate: #{gamma_rate(lines)}"
puts "epsilon rate: #{epsilon_rate(lines)}"
puts "part 1 multiple: #{gamma_rate(lines) * epsilon_rate(lines)}"

oxygen_rating_value = oxygen_rating(lines)
co2_rating_value = co2_rating(lines)
puts "oxygen rating: #{oxygen_rating_value}"
puts "co2 rating: #{co2_rating_value}"
puts "part 2 multiple: #{oxygen_rating_value * co2_rating_value}"