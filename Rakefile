require_relative 'config/environment'
require 'sinatra/activerecord/rake'
require_all 'lib'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = nil

  
  Pry.start
end

desc 'outputs hello to the terminal'
task :hello do
  puts "hello from Rake!"
end



#example from lab: Rake Intro
# namespace :greeting do 
#   desc 'outputs hello to the terminal'
#   task :hello do
#     puts "hello from Rake!"
#   end

#   desc 'outputs hola to the terminal'
#   task :hola do
#     puts "hola de Rake!"
#   end
# end


# namespace :db do 
#   desc 'migrate changes to your db'
#   task :migrate => :environment do
#     Student.create_table
#   end

#   desc 'seed the database with some dummy data'
#     task :seed do
#       require_relative './db/seeds'
#     end
# end

# task :environment do
#   require_relative './config/environment'
# end

# desc 'drop into the Pry console'
#   task :console => :environment do 
#     Pry.start
#   end

