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

lines = File.readlines(ARGV[0])

part_1 = increments_count(lines, 1)
part_3 = increments_count(lines, 3)

puts "part 1 (sliding window of 1): #{part_1}"
puts "part 2 (sliding window of 3): #{part_3}"