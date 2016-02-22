require "spec_helper"
require "lookup_address"

describe Addie::LookupAddress do
  it "returns results by the given country code" do
    result = Addie::LookupAddress.call(country_code: "TEST", street: "Street")
    expect(result).to eq({
      suggestions: [
        { street: "Kungsgatan", zipCode: "12345", city: "Norrby" },
      ]
    })
  end

  it "returns an empty result for unhandled countries" do
    result = Addie::LookupAddress.call(country_code: "ZZ", street: "Street")
    expect(result).to eq({
      suggestions: []
    })
  end
end
