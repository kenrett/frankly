# frozen_string_literal: true

require "fileutils"
require "pathname"
require "thor"
require "thor/group"

module Frankly
  class CLI < Thor::Group
    include Thor::Actions

    class_option :bundle, type: :boolean, default: false, desc: "Run bundle install after generation"
    class_option :skip_git, type: :boolean, default: false, desc: "Skip git init"

    desc "Creates a new Sinatra application"
    argument :name, type: :string, desc: "The name of the new application"

    def self.source_root
      File.expand_path("../../templates", __dir__)
    end

    def self.exit_on_failure?
      true
    end

    def setup
      @app_path = sanitized_app_path
    end

    def create_app_scaffold
      raise Thor::Error, "Directory '#{@app_path}' already exists" if File.exist?(@app_path)

      empty_directory @app_path
      empty_directory "#{@app_path}/app/controllers"
      empty_directory "#{@app_path}/app/helpers"
      empty_directory "#{@app_path}/app/models"
      empty_directory "#{@app_path}/db/migrate"
      create_file "#{@app_path}/app/controllers/.gitkeep"
      create_file "#{@app_path}/app/helpers/.gitkeep"
      create_file "#{@app_path}/app/models/.gitkeep"
      create_file "#{@app_path}/db/migrate/.gitkeep"
    end

    def copy_templates
      copy_file "app/views/layout.erb", "#{@app_path}/app/views/layout.erb"
      copy_file "app/views/index.erb", "#{@app_path}/app/views/index.erb"
      copy_file "app.rb", "#{@app_path}/app.rb"
      copy_file "config.ru", "#{@app_path}/config.ru"
      copy_file "Rakefile", "#{@app_path}/Rakefile"
      copy_file "config/database.rb", "#{@app_path}/config/database.rb"
      copy_file "config/environment.rb", "#{@app_path}/config/environment.rb"
      copy_file "db/seeds.rb", "#{@app_path}/db/seeds.rb"
      copy_file "README.md", "#{@app_path}/README.md"
      template "Gemfile.tt", "#{@app_path}/Gemfile"
      template "gitignore.tt", "#{@app_path}/.gitignore"
      copy_file "public/css/application.css", "#{@app_path}/public/css/application.css"
      copy_file "public/js/application.js", "#{@app_path}/public/js/application.js"
      copy_file "public/favicon.ico", "#{@app_path}/public/favicon.ico"
    end

    def initialize_git_repo
      return if options[:skip_git]

      inside(@app_path) { run("git init .") }
    end

    def install_dependencies
      return unless options[:bundle]

      inside(@app_path) { run("bundle install") }
    end

    private

    def sanitized_app_path
      cleaned = name.to_s.strip.downcase.gsub(/[^a-z0-9_-]/, "")
      raise Thor::Error, "APP_NAME must include at least one letter or number" if cleaned.empty?

      cleaned
    end
  end
end

Frankly::CLI.start if $PROGRAM_NAME == __FILE__
