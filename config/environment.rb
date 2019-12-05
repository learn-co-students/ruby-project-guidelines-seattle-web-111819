require 'bundler'
Bundler.require

require_relative '../models/artist'
require_relative '../models/event'
require_relative '../models/venue'

ActiveRecord::Base.logger = nil 

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/music_for_all.db')
require_all 'lib'
