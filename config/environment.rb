require 'bundler'
require 'io/console'
Bundler.require



ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/game_reviews.db')
ActiveRecord::Base.logger = nil

require_all 'lib'