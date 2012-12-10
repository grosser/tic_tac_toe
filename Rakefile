require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"

task :default => :spec
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--backtrace --color'
end

task :run do
  exec "./bin/tic_tac_toe"
end
