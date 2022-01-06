class Task
  def self.factory(task_no, input_name)
    require "./#{task_no}/task_#{task_no}"

    task_class = Object.const_get("Task#{task_no}")
    task_class.new("#{task_no}/#{input_name}")
  end

  def self.factory_cli(arguments)
    task_no = arguments[0]
    input_name = arguments.count >= 2 ? "#{arguments[1]}_input.txt" : "input.txt"

    factory(task_no, input_name)
  end

  attr_reader :input

  def initialize(file_name)
    @input = File.readlines(file_name)
  end

  def name
    self.class.name
  end

  def solve_part_1
    "Not Implemented"
  end

  def solve_part_2
    "Not Implemented"
  end

  def print_solution
    puts "#{name} - Part 1"
    puts "Result: #{solve_part_1}"
    puts
    puts "#{name} - Part 2"
    puts "Result: #{solve_part_2}"
  end
end