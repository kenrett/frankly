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
      @db_name = @app_path.tr("-", "_")
    end

    def create_app_scaffold
      raise Thor::Error, "Directory '#{@app_path}' already exists" if File.exist?(@app_path)

      empty_directory @app_path
      empty_directory "#{@app_path}/app/controllers"
      empty_directory "#{@app_path}/app/helpers"
      empty_directory "#{@app_path}/app/models"
      empty_directory "#{@app_path}/db/migrate"
      empty_directory "#{@app_path}/spec/requests"
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
      template "README.md.tt", "#{@app_path}/README.md"
      template "Gemfile.tt", "#{@app_path}/Gemfile"
      template "gitignore.tt", "#{@app_path}/.gitignore"
      copy_file ".rspec", "#{@app_path}/.rspec"
      copy_file "spec/spec_helper.rb", "#{@app_path}/spec/spec_helper.rb"
      copy_file "spec/requests/app_spec.rb", "#{@app_path}/spec/requests/app_spec.rb"
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

    def print_next_steps
      say "\nNext steps:"
      say "  cd #{@app_path}"
      say "  bundle install#{options[:bundle] ? ' (already run because you passed --bundle)' : ''}"
      say "  bundle exec rackup"
      say "  Set DATABASE_URL in your environment (or use the defaults in config/database.rb)."
      say "  Database setup is required for persistence (create DB and run migrations)."
    end

    private

    def sanitized_app_path
      raw_name = name.to_s.strip
      raise Thor::Error, "APP_NAME cannot be blank" if raw_name.empty?
      unless raw_name.match?(/\A[a-zA-Z0-9][a-zA-Z0-9_-]*\z/)
        raise Thor::Error, "APP_NAME may only include letters, numbers, hyphens, and underscores"
      end

      raw_name.downcase
    end
  end
end

Frankly::CLI.start if $PROGRAM_NAME == __FILE__
