require 'dotenv/tasks'
require 'rake/testtask'

desc "Run all tests"
task :all => [:dotenv] do
  Rake::TestTask.new do |t|
    t.name = 'all'
    t.libs << "test/integration"
    t.test_files = FileList['test/integration/*_test.rb']
    t.verbose = true
  end
end

desc "Run resources tests"
task :resources => [:dotenv] do
  Rake::TestTask.new do |t|
    t.name = 'resources'
    t.libs << "test/integration"
    t.test_files = FileList['test/integration/resources_test.rb']
    t.verbose = true
  end
end

desc "Run masterdata tests"
task :masterdata => [:dotenv] do
  Rake::TestTask.new do |t|
    t.name = 'masterdata'
    t.libs << "test/integration"
    t.test_files = FileList['test/integration/masterdata_test.rb']
    t.verbose = true
  end
end

desc "Run metrics tests"
task :metrics => [:dotenv] do
  Rake::TestTask.new do |t|
    t.name = 'metrics'
    t.libs << "test/integration"
    t.test_files = FileList['test/integration/metrics_test.rb']
    t.verbose = true
  end
end