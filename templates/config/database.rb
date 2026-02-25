# frozen_string_literal: true

require "logger"
require "uri"

rack_env = ENV.fetch("RACK_ENV", "development")
ActiveRecord::Base.logger = Logger.new($stdout) if rack_env == "development"

build_db_config = lambda do |env_name|
  database_url = ENV.fetch("DATABASE_URL", "postgres://localhost/#{APP_NAME}_#{env_name}")
  uri = URI.parse(database_url)
  database_name = uri.path.sub(%r{^/}, "")
  adapter = uri.scheme == "postgres" ? "postgresql" : uri.scheme

  {
    adapter: adapter,
    host: uri.host,
    port: uri.port,
    username: uri.user,
    password: uri.password,
    database: database_name,
    encoding: "utf8"
  }.compact
end

ActiveRecord::Base.configurations = {
  "development" => build_db_config.call("development"),
  "test" => build_db_config.call("test"),
  "production" => build_db_config.call("production")
}

ActiveRecord::Base.establish_connection(rack_env.to_sym)
