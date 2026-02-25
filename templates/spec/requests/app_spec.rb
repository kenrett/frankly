# frozen_string_literal: true

require "spec_helper"

RSpec.describe "GET /" do
  def app
    App
  end

  it "returns 200 with the default home page content" do
    get "/"

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Frankly, it works.")
  end
end
