require "spec_helper"
require "look_up_address"

describe Addie::LookUpAddress do
  it "returns results by the given country code" do
    result = Addie::LookUpAddress.call(country_code: "TEST", street: "Street")
    expect(result).to eq({
      suggestions: [
        { street: "Kungsgatan 321", zipCode: "12345", city: "Norrby" },
      ]
    })
  end

  it "returns an empty result for unhandled countries" do
    result = Addie::LookUpAddress.call(country_code: "ZZ", street: "Street")
    expect(result).to eq({
      suggestions: []
    })
  end
end
