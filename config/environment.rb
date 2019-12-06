require 'bundler'
require 'io/console'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'models'
require_all 'lib'

ActiveRecord::Base.logger = nil

