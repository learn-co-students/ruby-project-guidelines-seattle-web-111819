require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  # ActiveRecord::Base.logger = Logger.new(STDOUT)

  sp = {t: 10, l: 20, w: 80}
  input = display_menu(["Main Menu:", ""], ["Login", "Create Account", "Continue as a Guest", "Exit"], "", sp)

  puts "\n\n\n"
  puts input




  Pry.start
end
