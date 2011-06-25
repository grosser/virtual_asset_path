require 'rake/testtask'
Rake::TestTask.new(:default) do |test|
  test.libs << 'lib'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :all do
  sh "RAILS=2.3.12 bundle && bundle exec rake"
  sh "RAILS=3.0.8 bundle && bundle exec rake"
#  sh "RAILS=3.1.0.rc4 bundle && bundle exec rake"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'virtual_asset_path'
    gem.summary = "Instantly expired, cacheable assets, without query params"
    gem.email = "michael@grosser.it"
    gem.homepage = "http://github.com/grosser/#{gem.name}"
    gem.authors = ["Michael Grosser"]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end
