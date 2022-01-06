class Task1 < Task
  def name
    "Day 1: Sonar Sweep"
  end

  def increments_count(lines, sliding_window_size)
    increments, _ = lines.reduce([0,[]]) do |(count, prev_window), line|
      depth = line.strip.to_i
      next [0, prev_window + [depth]] if prev_window.size < sliding_window_size
      
      window = prev_window[1..-1] + [depth]
      # puts "#{window} > #{prev_window}"
      if window.sum > prev_window.sum
        [count + 1, window]
      else
        [count, window]
      end
    end

    increments
  end

  def solve_part_1
    increments_count(input, 1)
  end

  def solve_part_2
    increments_count(input, 3)
  end
end
