require "./lib/task"

task = Task.factory_cli(ARGV)
task.print_solution