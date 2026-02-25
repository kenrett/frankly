# frozen_string_literal: true

require "logger"
require "uri"

rack_env = ENV.fetch("RACK_ENV", "development")
ActiveRecord::Base.logger = Logger.new($stdout) if rack_env == "development"

database_url = ENV.fetch("DATABASE_URL", "postgres://localhost/#{APP_NAME}_#{rack_env}")
uri = URI.parse(database_url)

database_name = uri.path.sub(%r{^/}, "")
adapter = uri.scheme == "postgres" ? "postgresql" : uri.scheme

ActiveRecord::Base.establish_connection(
  adapter: adapter,
  host: uri.host,
  port: uri.port,
  username: uri.user,
  password: uri.password,
  database: database_name,
  encoding: "utf8"
)
