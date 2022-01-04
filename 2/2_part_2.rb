lines = File.readlines(ARGV[0])

_, final_depth, final_horizontal = lines.reduce([0, 0, 0]) do |(aim, depth, horizontal), line|
  instruction, count = line.strip.split(" ")
  count = count.to_i
  
  case instruction
  when "down"
    [aim + count, depth, horizontal]
  when "up"
    [aim - count, depth, horizontal]
  when "forward"
    [aim, depth + (aim * count), horizontal + count]
  end 
end

puts "depth: #{final_depth}"
puts "horizontal position: #{final_horizontal}"
puts "multiple: #{final_depth * final_horizontal}"