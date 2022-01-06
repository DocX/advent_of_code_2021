class Task6 < Task
  NEW_FISH_TIMER = 9
  RESET_TIMER = 7

  def name
    "Day 6: Lanternfish"
  end

  def simulate_days(timer_counts, days)
    # puts "Initial: #{timer_counts}"
    day = 1
    while day <= days
      # reset 0 and produce new fishes
      timer_counts[NEW_FISH_TIMER] = timer_counts[0] if timer_counts[0]
      timer_counts[RESET_TIMER] = (timer_counts[RESET_TIMER] || 0) + (timer_counts[0] || 0)
      timer_counts.delete 0

      # decrement timer
      timer_counts.transform_keys! { |t| t - 1 }
      # puts "Day #{day}: #{timer_counts}"
      day = day + 1
    end

    timer_counts.values.sum
  end

  def initial_timers
    fish_timers = input[0].split(",").map(&:to_i)
    fish_timers.tally
  end

  def solve_part_1
    simulate_days(initial_timers, 80)
  end

  def solve_part_2    
    simulate_days(initial_timers, 256)
  end
end