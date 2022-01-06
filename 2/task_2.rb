class Task2 < Task
  def name
    "Day 2: Dive!"
  end
  
  def solve_part_1
    final_depth, final_horizontal = input.reduce([0, 0]) do |(depth, horizontal), line|
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
    
    final_depth * final_horizontal
  end

  def solve_part_2
    _, final_depth, final_horizontal = input.reduce([0, 0, 0]) do |(aim, depth, horizontal), line|
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
    
    final_depth * final_horizontal
  end
end