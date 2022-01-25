class Task9 < Task
  def name
    "Day 9: Smoke Basin"
  end

  def heightmap
    @heightmap ||= input.map do |line|
      line.strip.chars.map(&:to_i)
    end
  end

  def low_points
    heightmap.each_with_index.reduce([]) do |minimas, (row, row_index)|
      row.each_with_index.reduce(minimas) do |minimas_row, (value, col_index)|
        if low_point?(row_index, col_index)
          minimas_row + [[row_index, col_index]]
        else
          minimas_row
        end
      end
    end
  end

  def low_point?(row, col)
    value = heightmap[row][col]

    neighbors = []
    neighbors << heightmap[row - 1][col] if row - 1 >= 0
    neighbors << heightmap[row + 1][col] if row + 1 < heightmap.count
    neighbors << heightmap[row][col - 1] if col - 1 >= 0
    neighbors << heightmap[row][col + 1] if col + 1 < heightmap[0].count

    value < neighbors.min 
  end

  def basins
    low_points.map do |low_r, low_c|
      upwards_points([], low_r, low_c)
    end
  end

  def upwards_points(points, row, col)
    return points if points.include?([row, col])
    return points unless valid_point?(row, col)

    next_value = heightmap[row][col]
    return points unless next_value < 9

    next_points = points + [[row, col]]
    next_points = upwards_points(next_points, row - 1, col)
    next_points = upwards_points(next_points, row + 1, col)
    next_points = upwards_points(next_points, row, col - 1)
    next_points = upwards_points(next_points, row, col + 1)
    next_points
  end

  def valid_point?(row, col)
    row >= 0 && row < heightmap.count && col >= 0 && col < heightmap[0].count
  end

  def solve_part_1
    low_points.map { |r, c| heightmap[r][c] + 1 }.sum
  end

  def solve_part_2
    # Find all "basins" - basin is are that is surounded by 9 (walls) around the low points
    # Take the 3 largest (by area = number of points)
    # Multiply the sizes of those 3

    debug_log { basins.to_s }
    counts = basins.map(&:count)
    debug_log { counts.join(", ") }
    counts.max(3).reduce(&:*)

    # basins.map do |basin|
    #   heightmap.count.times.map do |r|
    #     heightmap[0].count.times.map do |c|
    #       basin.include?([r,c]) ? heightmap[r][c] : "."
    #     end.join("")
    #   end.join("\n")
    # end.each do |basin| 
    #   debug_log { basin }
    #   debug_log { "" }
    # end
  end
end