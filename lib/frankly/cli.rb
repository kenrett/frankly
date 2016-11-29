require 'pathname'
require 'fileutils'
require 'thor'
require 'thor/group'

module Frankly
  class CLI < Thor::Group
    include Thor::Actions

    def self.source_root
      File.expand_path('../../../templates', __FILE__)
    end

    desc "Creates a new Sinatra application"
    argument :name, :type => :string, :desc => "The name of the new application"

    def setup
      @app_path = name.downcase.gsub(/[^a-z|\-|\_]/, '')
    end

    def create_app_scaffold
      empty_directory "#{@app_path}/app"
      create_file "#{@app_path}/app/models/.gitkeep"
      create_file "#{@app_path}/app/controllers/.gitkeep"
      create_file "#{@app_path}/app/views/.gitkeep"
      create_file "#{@app_path}/app/helpers/.gitkeep"
      create_file "#{@app_path}/config/.gitkeep"
      create_file "#{@app_path}/db/migrate/.gitkeep"
      create_file "#{@app_path}/public/css/.gitkeep"
      create_file "#{@app_path}/public/js/.gitkeep"
    end

    def copy_templates
      copy_file "app/views/layout.erb", "#{@app_path}/app/views/layout.erb"
      copy_file "config.ru", "#{@app_path}/config.ru"
      copy_file "Rakefile", "#{@app_path}/Rakefile"
      copy_file "config/database.rb", "#{@app_path}/config/database.rb"
      copy_file "config/environment.rb", "#{@app_path}/config/environment.rb"
      copy_file "db/seeds.rb", "#{@app_path}/db/seeds.rb"
      copy_file "README.md", "#{@app_path}/README.md"
      copy_file "Gemfile", "#{@app_path}/Gemfile"
      copy_file "public/css/application.css", "#{@app_path}/public/css/application.css"
      copy_file "public/css/normalize.css", "#{@app_path}/public/css/normalize.css"
      copy_file "public/js/application.js", "#{@app_path}/public/js/application.js"
      copy_file "public/favicon.ico", "#{@app_path}/public/favicon.ico"
    end

    def initialize_git_repo
      puts "about to run git init"
      inside(@app_path) do
        run('git init .')
      end
    end

    def install_dependencies
      puts "installing dependencies"
      inside(@app_path) do
        run('bundle')
      end
    end
  end
end

if __FILE__ == $0
  cli = Frankly::CLI.start
end
