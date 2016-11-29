require "spec_helper"

describe Frankly do
  it "has a version number" do
    expect(Frankly::VERSION).not_to be nil
  end

  context "when generating a new skeleton" do
    @templates_path = "#{File.dirname(__FILE__)}/../lib/sinatra_generator/templates"
    @tmp_dir = Dir.mktmpdir
    Dir.chdir @tmp_dir

    it "does something useful" do
      expect(@tmp_dir).to_not be nil
    end
  end
end
