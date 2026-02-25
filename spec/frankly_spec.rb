# frozen_string_literal: true

require "fileutils"
require "spec_helper"
require "tmpdir"

RSpec.describe Frankly::CLI do
  def run_cli(*args, options: {})
    described_class.new(args.flatten, options, {}).invoke_all
  end

  def with_temp_workdir
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) { yield tmp_dir }
    end
  end

  it "has a version number" do
    expect(Frankly::VERSION).not_to be_nil
  end

  it "generates key scaffold files and no .DS_Store files" do
    with_temp_workdir do
      run_cli("test_app", options: { skip_git: true })

      expect(File.directory?("test_app")).to be(true)
      expect(File.exist?("test_app/Gemfile")).to be(true)
      expect(File.exist?("test_app/config.ru")).to be(true)
      expect(File.exist?("test_app/app.rb")).to be(true)
      expect(File.exist?("test_app/bin/console")).to be(true)
      expect(File.executable?("test_app/bin/console")).to be(true)
      expect(File.exist?("test_app/config/database.rb")).to be(true)
      expect(File.exist?("test_app/README.md")).to be(true)
      expect(File.exist?("test_app/.rspec")).to be(true)
      expect(File.exist?("test_app/spec/spec_helper.rb")).to be(true)
      expect(File.exist?("test_app/spec/requests/app_spec.rb")).to be(true)

      generated_dotfiles = Dir.glob("test_app/**/*", File::FNM_DOTMATCH)
      ds_store_paths = generated_dotfiles.select { |path| File.basename(path) == ".DS_Store" }
      expect(ds_store_paths).to be_empty
    end
  end

  it "normalizes valid app names and derives underscore db defaults in README" do
    with_temp_workdir do
      run_cli("My-App_1", options: { skip_git: true })

      expect(File.directory?("my-app_1")).to be(true)
      readme = File.read("my-app_1/README.md")
      expect(readme).to include("# my-app_1")
      expect(readme).to include("postgres://localhost/my_app_1_development")
      expect(readme).not_to include("<app_name>")
    end
  end

  it "rejects a blank app name" do
    with_temp_workdir do
      expect { run_cli("   ") }.to raise_error(Thor::Error, /APP_NAME cannot be blank/)
    end
  end

  it "rejects invalid app names with special characters" do
    with_temp_workdir do
      expect { run_cli("bad$name") }
        .to raise_error(Thor::Error, /APP_NAME may only include letters, numbers, hyphens, and underscores/)
    end
  end

  it "fails when target directory already exists with a helpful error" do
    with_temp_workdir do
      FileUtils.mkdir_p("existing_app")

      expect { run_cli("existing_app") }
        .to raise_error(Thor::Error, /Directory 'existing_app' already exists/)
    end
  end

  it "skips git init when --skip-git is passed" do
    with_temp_workdir do
      cli = described_class.new(["skip_git_app"], { skip_git: true }, {})
      expect(cli).not_to receive(:run).with("git init .")
      cli.invoke_all
    end
  end

  it "runs bundle install when --bundle is passed" do
    with_temp_workdir do
      cli = described_class.new(["bundle_app"], { bundle: true, skip_git: true }, {})
      expect(cli).to receive(:run).with("bundle install").and_return(true)
      cli.invoke_all
    end
  end
end
