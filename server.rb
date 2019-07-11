require "sinatra"
require "sinatra/activerecord"
# require "sinatra/flash"
# require "sqlite3"
# require "rake"

enable :sessions

if ENV['RACK_ENV']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  set :database, {adapter: "sqlite3", database: "database.sqlite3"}
end

class User < ActiveRecord::Base
end

# LOCAL
# ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "./db.sqlite3")
# HEROKU

# require "active_record"
# ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])

get "/" do
  erb :home
end

get "/signup" do
  erb :signup
end

post "/signup" do
  user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], birthday: params[:birthday], username: params[:username], password: params[:password])
  user.save
  redirect "/"
end

get "/login" do
  erb :login
end

post "/login" do
  username = params[:username]
  given_password = params[:password]
  user = User.find_by(username: username)
  session[:user] = user
  redirect "/"
end

get "/profile" do
  erb :profile
end

get "/settings/account" do
  erb :"settings/account"
end
