class Task8 < Task
  SEGMENTS_TO_DIGIT_MAPPING = {
    "abcefg" => 0,
    "cf" => 1,
    "acdeg" => 2,
    "acdfg" => 3,
    "bcdf" => 4,
    "abdfg" => 5,
    "abdefg" => 6,
    "acf" => 7,
    "abcdefg" => 8,
    "abcdfg" => 9
  }.freeze

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

  def decode_signal_mapping(signals)
    #  aa
    # b  c
    # b  c
    #  dd
    # e  f
    # e  f
    #  gg

    # 1 .. 2 segments
    # 2 .. 5 segments
    # 3 .. 5 segments
    # 4 .. 4 segments
    # 5 .. 5 segments
    # 6 .. 6 segments
    # 7 .. 3 segments 
    # 8 .. 7 segments
    # 9 .. 6 segments

    cf_mapping = signals.find { |s| s.size == 2 }.chars
    bdcf_mapping = signals.find { |s| s.size == 4 }.chars
    acf_mapping = signals.find { |s| s.size == 3 }.chars
    abcdefg_mapping = signals.find { |s| s.size == 7 }.chars

    signals_2_3_or_5 = signals.select { |s| s.size == 5 }.map(&:chars)

    a_mapping = acf_mapping - cf_mapping

    # adg is the only ones present in all 2 3 and 5
    adg_mapping = signals_2_3_or_5.flatten.tally.select { |_, count| count == 3 }.map { |k, _| k }
    bd_mapping = bdcf_mapping - cf_mapping
    
    d_mapping = adg_mapping.intersection bd_mapping
    g_mapping = adg_mapping - d_mapping - a_mapping
    b_mapping = bd_mapping - d_mapping

    eg_mapping = abcdefg_mapping - bdcf_mapping - acf_mapping
    e_mapping = eg_mapping - g_mapping

    # signals that contains e is 2
    signal_2 = signals_2_3_or_5.find { |signal| signal.include?(e_mapping[0]) }
    
    c_mapping = signal_2 - adg_mapping - e_mapping
    f_mapping = cf_mapping - c_mapping

    {
      a_mapping[0] => "a",
      b_mapping[0] => "b",
      c_mapping[0] => "c",
      d_mapping[0] => "d",
      e_mapping[0] => "e",
      f_mapping[0] => "f",
      g_mapping[0] => "g",
    }
  end

  def decode_digit(mapping, digit)
    digit.chars.map { |c| mapping[c] }.sort.join("")
  end

  def decode_entry_outputs(entry)
    debug_log { "Entry: #{entry[:inputs].to_s}" }
    signal_mapping = decode_signal_mapping(entry[:inputs])
    debug_log { "Mapping: #{signal_mapping}" }
    entry[:outputs].map { |output| decode_digit(signal_mapping, output) }
  end

  def solve_part_2
    numbers = entries.map do |entry|
      decoded_outputs = decode_entry_outputs(entry)
      number = decoded_outputs.map { |output| SEGMENTS_TO_DIGIT_MAPPING[output] }.join.to_i
      debug_log { "Number: #{number}" }
      number
    end

    numbers.sum
  end
end