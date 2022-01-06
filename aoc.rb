require "./lib/task"

if ARGV.count > 0
  task = Task.factory_cli(ARGV)
  task.print_solution
else
  (1..7).each do |task_no|
    Task.factory(task_no, "input.txt").print_solution
  end
end