lines = File.readlines(ARGV[0])

final_depth, final_horizontal = lines.reduce([0, 0]) do |(depth, horizontal), line|
  instruction, count = line.strip.split(" ")
  count = count.to_i
  
  case instruction
  when "down"
    [depth + count, horizontal]
  when "up"
    [depth - count, horizontal]
  when "forward"
    [depth, horizontal + count]
  end 
end

puts "depth: #{final_depth}"
puts "horizontal position: #{final_horizontal}"
puts "multiple: #{final_depth * final_horizontal}"