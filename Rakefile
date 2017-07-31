require 'dotenv/tasks'
require 'rake/testtask'

desc "Run analytics tests"
task :analytics => [:dotenv] do
  Rake::TestTask.new do |t|
    t.name = 'analytics'
    t.libs << "test/analytics"
    t.test_files = FileList['test/analytics/*_test.rb']
    t.verbose = true
  end
end

