require 'bundler'
Bundler.require
require './hello'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
run Sinatra::Application
