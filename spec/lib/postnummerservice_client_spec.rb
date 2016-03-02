require "spec_helper"
require "postnummerservice_client"

describe PostnummerserviceClient, "#look_up" do
  it "returns the result in the format we expect" do
    endpoint = double(:endpoint)
    response = {
      response: {
        suggestions: [
           { street: "Kungs Barkarö Kyrka", postalcode: "73693", locality: "Kungsör" },
         ]
       }
    }
    allow(endpoint).to receive(:suggest_by_street).with("Kungs").and_return(response)

    result = PostnummerserviceClient.look_up(endpoint: endpoint, street: "Kungs", country_code: "Ignored")

    expect(result).to eq([
      { street: "Kungs Barkarö Kyrka", zipCode: "73693", city: "Kungsör" },
    ])
  end
end
