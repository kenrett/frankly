# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Template hygiene" do
  it "does not include .DS_Store files under templates/" do
    matches = Dir.glob(File.expand_path("../templates/**/.DS_Store", __dir__))
    expect(matches).to be_empty
  end
end
