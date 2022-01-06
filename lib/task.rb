class Task
  def self.factory(task_no, input_name)
    require "./#{task_no}/task_#{task_no}"

    task_class = Object.const_get("Task#{task_no}")
    task_class.new("#{task_no}/#{input_name}")
  end

  def self.factory_cli(arguments)
    flags = arguments.select { |arg| arg.start_with? "--" }
    params = arguments - flags

    task_no = params[0]
    input_name = params.count >= 2 ? "#{params[1]}_input.txt" : "input.txt"

    task = factory(task_no, input_name)
    task.debug = true if flags.include?("--debug")
    task
  end

  attr_reader :input
  attr_accessor :debug

  def initialize(file_name)
    @input = File.readlines(file_name)
    @debug = false
  end

  def name
    self.class.name
  end

  def debug_log
    return unless debug?

    puts yield
  end

  def debug?
    @debug
  end

  def solve_part_1
    "Not Implemented"
  end

  def solve_part_2
    "Not Implemented"
  end

  def print_solution
    debug_log { "#{name} - Part 1:" }
    puts "#{name} - Part 1: #{solve_part_1}"
    
    debug_log { "" }
    debug_log { "#{name} - Part 2:" }
    puts "#{name} - Part 2: #{solve_part_2}"
  end
end