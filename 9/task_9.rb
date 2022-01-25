class Task9 < Task
  def name
    "Day 9: Smoke Basin"
  end

  def heightmap
    @heightmap ||= input.map do |line|
      line.strip.chars.map(&:to_i)
    end
  end

  def local_minimas
    heightmap.each_with_index.reduce([]) do |minimas, (row, row_index)|
      row.each_with_index.reduce(minimas) do |minimas_row, (value, col_index)|
        if low_point?(row_index, col_index)
          minimas_row + [value]
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

  def solve_part_1
    local_minimas.map { |i| i + 1 }.sum
  end
end