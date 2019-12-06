require_relative 'config/environment'
require 'sinatra/activerecord/rake'
require_all 'lib'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = nil

  
  Pry.start
end

# desc 'outputs hello to the terminal'
# task :hello do
#   puts "hello from Rake!"
# end



