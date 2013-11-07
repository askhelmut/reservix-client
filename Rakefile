begin
  require 'bundler'
  Bundler::GemHelper.install_tasks
rescue LoadError
  puts 'although not required, bundler is recommended during development'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec

task :release do
  sh "gem build reservix-client.gemspec"
  sh "gem push reservix-client*.gem"
end
