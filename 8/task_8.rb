class Task8 < Task
  def name
    "Day 8: Seven Segment Search"
  end

  def entries
    input.map do |line|
      inputs, outputs = line.split("|").map { |i| i.split(" ") }
      {
        inputs: inputs,
        outputs: outputs,
      }
    end
  end

  def unique_digits(digits)
    digits.select { |digit| is_unique?(digit) }
  end
  
  def is_unique?(digit)
    debug_log { digit }
    case digit.size
    when 2, 3, 4, 7
      true
    else
      false
    end
  end

  def solve_part_1
    entries.map { |entry| unique_digits(entry[:outputs]).count }.sum
  end
end