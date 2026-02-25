# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

RSpec.describe Frankly do
  it "has a version number" do
    expect(Frankly::VERSION).not_to be_nil
  end

  it "generates a Sinatra scaffold" do
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) do
        Frankly::CLI.start(["test_app", "--skip-git"])

        expect(File.directory?("test_app")).to be(true)
        expect(File.exist?("test_app/app.rb")).to be(true)
        expect(File.exist?("test_app/config.ru")).to be(true)
        expect(File.exist?("test_app/Gemfile")).to be(true)
        expect(File.exist?("test_app/.gitignore")).to be(true)
        expect(File.exist?("test_app/app/views/layout.erb")).to be(true)
        expect(File.exist?("test_app/app/views/index.erb")).to be(true)
        expect(File.exist?("test_app/public/css/application.css")).to be(true)
        expect(File.exist?("test_app/public/js/application.js")).to be(true)
      end
    end
  end
end
