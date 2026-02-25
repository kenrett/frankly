# frozen_string_literal: true

require "sinatra/base"
require_relative "config/environment"

class App < Sinatra::Base
  configure do
    set :root, APP_ROOT.to_s
    set :public_folder, APP_ROOT.join("public").to_s
    set :views, APP_ROOT.join("app", "views").to_s
  end

  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    @app_name = APP_NAME
    erb :index
  end

  run! if app_file == $PROGRAM_NAME
end
