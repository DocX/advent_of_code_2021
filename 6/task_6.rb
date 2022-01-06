class Task6 < Task
  NEW_FISH_TIMER = 9
  RESET_TIMER = 7

  def name
    "Day 6: Lanternfish"
  end

  def simulate_days(times, days)
    day = 1
    while day <= days
      # reset 0 and produce new fishes
      times = times + Array.new(times.count { |t| t == 0 }, NEW_FISH_TIMER)
      times = times.map { |t| t == 0 ? RESET_TIMER : t }

      # decrement timer
      times = times.map { |t| t - 1 }
      # puts "Day #{day}: #{times}"
      day = day + 1
    end

    times.count
  end

  def solve_part_1
    fish_times = input[0].split(",").map(&:to_i)
    # puts "Initial: #{fish_times}"
    
    simulate_days(fish_times, 80)
  end
end