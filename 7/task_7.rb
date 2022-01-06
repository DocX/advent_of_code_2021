class Task7 < Task
  def name
    "Day 7: The Treachery of Whales"
  end

  def horizontal_positions
    @horizontal_positions ||= input[0].split(",").map(&:to_i)
  end

  def cost_to_move_linear(initial, target)
    initial.map { |p| (p - target).abs }.sum
  end

  def least_change_position_cost(positions)
    min = positions.min
    max = positions.max
    
    costs = (min .. max).map { |test_position| yield positions, test_position }
    costs.min
  end

  def solve_part_1
    least_change_position_cost(horizontal_positions) do |positions, test_position|
      cost_to_move_linear(positions, test_position)
    end
  end

  def cost_to_move_incremental(initial, target)
    # cost(1) = 1
    # cost(n) = cost(n-1) + 1
    # or
    # cost(n) = sum(i = 1..n) { i } = (n)(n+1) / 2
    initial.map do |p| 
      n = (p - target).abs
      (n * (n + 1)) / 2
    end.sum
  end

  def solve_part_2
    least_change_position_cost(horizontal_positions) do |positions, test_position|
      cost_to_move_incremental(positions, test_position)
    end
  end
end