require "spec_helper"
require "tmpdir"
require "logger"

describe Frankly do
  it "has a version number" do
    expect(Frankly::VERSION).not_to be nil
  end

  context "when generating a new skeleton" do
    before(:all) do
      @templates_path = "#{File.dirname(__FILE__)}/../lib/sinatra_generator/templates"
      @tmp_dir = Dir.mktmpdir
      Dir.chdir @tmp_dir
    end

    it "creates a temporary directory" do
      expect(@tmp_dir).to_not be nil
    end

    it "builds a new app" do
      Frankly::CLI.start ["test_app"]

      expect(File.directory?('test_app')).to be true

      Dir.chdir 'test_app' do
        expect(File.exist?('config.ru')).to be true
        expect(File.exist?('Gemfile')).to be true
        expect(File.exist?('Rakefile')).to be true
        expect(File.exist?('README.md')).to be true
        expect(File.directory?('app')).to be true
        expect(File.directory?('config')).to be true
        expect(File.directory?('db')).to be true
        expect(File.directory?('public')).to be true
      end
    end

    after(:all) do
      Dir.chdir('..')
      FileUtils.rm_rf @tmp_dir
      expect(File.directory?(@tmp_dir)).to be false
    end
  end
end
