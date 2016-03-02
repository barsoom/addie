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
        { street: "Kungsgatan 321", zipCode: "12345", city: "Norrby" },
      ]
    }

    get "/api/v1/lookup?street=Kungs&country_code=TEST"

    expect(last_response.status).to eq(200)

    data = JSON.parse(last_response.body, symbolize_names: true)
    expect(data).to eq(expected)
  end

  it "returns a validation given a street, zip code and city" do
    expected = {
      valid: true,
      message: "",
    }

    get "/api/v1/validate?street=Grev%20Turegatan%2044&zip_code=11438&city=Stockholm&country_code=TEST"

    expect(last_response.status).to eq(200)

    data = JSON.parse(last_response.body, symbolize_names: true)
    expect(data).to eq(expected)
  end

  it "returns a Bad Request (400) error if one or more of the required arguements is missing" do
    expected = {
      error: "Missing parameter: street"
    }

    get "/api/v1/lookup?country_code=TEST"

    expect(last_response.status).to eq(400)

    data = JSON.parse(last_response.body, symbolize_names: true)
    expect(data).to eq(expected)
  end
end
