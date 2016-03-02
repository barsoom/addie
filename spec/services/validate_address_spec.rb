require "spec_helper"
require "validate_address"

describe Addie::ValidateAddress do
  it "returns a valid response for valid input" do
    result = Addie::ValidateAddress.call(street: "Kungsgatan 321", zip_code: "12345", city: "Norrby", country_code: "TEST")
    expect(result).to eq({ valid: true, message: "" })
  end

  it "returns a invalid response given a bad zip code" do
    result = Addie::ValidateAddress.call(street: "Kungsgatan 321", zip_code: "54321", city: "Norrby", country_code: "TEST")
    expect(result).to eq({ valid: false, message: "No match!" })
  end
end
