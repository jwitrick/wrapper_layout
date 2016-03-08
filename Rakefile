require 'rubygems'
require 'English'
require 'bundler/setup'
require 'rubocop/rake_task'
require 'cane/rake_task'
require 'rspec/core/rake_task'
require 'foodcritic'
require 'kitchen/rake_tasks'
require 'stove/rake_task'

desc 'Run Cane to check code quality metrics'
Cane::RakeTask.new

desc 'Run RuboCop to lint check Ruby code'
RuboCop::RakeTask.new

desc 'Display LOC stats'
task :loc do
  puts "\n## LOC Stats"
  sh 'countloc -r .'
end

desc 'Run knife cookbook syntax test'
task :cookbook_test do
  path = File.expand_path('../..', __FILE__)
  cb = File.basename(File.expand_path('..', __FILE__))
  Kernel.system "knife cookbook test -c test/knife.rb -o #{path} #{cb}"
  $CHILD_STATUS == 0 || raise('Cookbook syntax check failed!')
end

desc 'Run Foodcritic lint tests'
FoodCritic::Rake::LintTask.new do |f|
  f.options = {
    fail_tags: %w(any),
    tags: ['~FC023', '~FC009', '~FC0014', '~FC0015'],
    exclude_paths: ['providers/', 'libraries/']
  }
end

desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = ['**/**{,/*/**}/*_spec.rb']
  # t.rspec_opts = '--no-drb -r rspec_junit_formatter --format RspecJunitFormatter -o junit.xml'
end

desc 'Run a full converge test'
task :converge do
  raise 'Convergence tests not yet implemented'
end

task default: %w(cane rubocop loc cookbook_test foodcritic spec)

# vim: ai et ts=2 sts=2 sw=2 ft=ruby fdm=marker
