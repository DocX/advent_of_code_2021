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
      basin_from(low_r, low_c)
    end
  end

  def basin_from(row, col)
    queue = [[row, col]]
    basin = []

    # Breadth First Search
    until queue.empty?
      row, col = queue.pop

      next if basin.include?([row, col])
      next unless valid_point?(row, col)

      next_value = heightmap[row][col]
      next unless next_value < 9

      basin << [row, col]
      queue << [row - 1, col]
      queue << [row + 1, col]
      queue << [row, col - 1]
      queue << [row, col + 1]
    end

    basin
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
  end
end