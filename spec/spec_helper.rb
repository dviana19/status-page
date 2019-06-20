require "rspec"

# loads all files that will be tested
dir_libs  = File.expand_path(File.dirname("../")) << "/libs/**/*.rb"
Dir[dir_libs].each { |f| load f }
