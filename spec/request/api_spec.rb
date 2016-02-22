ENV["RACK_ENV"] = "test"

require_relative "../../config/boot"
require "spec_helper"
require "rack/test"

include Rack::Test::Methods

def app
  Padrino.application
end

describe "API", type: :rack_test do
  it "returns suggestions given a street and a country code" do
    expected = {
      suggestions: [
        { street: "Kungs Barkarö Kyrka", zipCode: "73693", city: "Kungsör" },
        { street: "Kungs Norrby", zipCode: "59028", city: "Borensberg" },
        { street: "Kungs-Husby Ryttesta", zipCode: "74599", city: "Enköping" },
      ]
    }

    get "/api/v1/lookup?street=Kungs&country_code=SE"
    expect(last_response.status).to eq(200)
    data = JSON.parse(last_response.body, symbolize_names: true)
    pending
    expect(data).to eq(expected)
  end
end
