# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
require "bundler/setup"

require "pathname"

require "active_record"
require "erb"
require "sinatra/reloader"

APP_ROOT = Pathname.new(File.expand_path("..", __dir__))
APP_NAME = APP_ROOT.basename.to_s

Dir[APP_ROOT.join("app", "helpers", "*.rb")].sort.each { |file| require file }
Dir[APP_ROOT.join("app", "controllers", "*.rb")].sort.each { |file| require file }
Dir[APP_ROOT.join("app", "models", "*.rb")].sort.each { |file| require file }

require APP_ROOT.join("config", "database")
