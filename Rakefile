require 'rake'
require 'rake/testtask'
require 'rubygems/package_task'

spec = Gem::Specification.load("boring.gemspec")
pkg  = Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Install the current gem"
task "install" => [:gem] do
  path = pkg.package_dir_path
  system 'gem', 'install', path
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc "Run tests against packaged binary"
task "test:acceptance" => [:gem, :bin_path, :test]

task "bin_path" => [:gem] do
  path = pkg.package_dir_path
  ENV["BIN_PATH"] = path + "/bin/boring"
end

task :default => :test