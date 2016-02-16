require "spec_helper"
require "postnummerservice_client"

describe PostnummerserviceClient, ".suggest_address" do
  it "returns address suggestions based on a whole/partial street" do
    response = {
      "name"=>"Valid API",
      "type"=>"Address suggestions",
      "version"=>"11.45",
      "encoding"=>"utf-8",
      "options"=> {
        "api_key"=>"my very secret api key",
        "suggest"=>"street",
        "lang"=>"se",
        "charset"=>"utf-8",
        "response_format"=>"json",
        "max_rows"=>20,
        "cols"=>"street,postalcode,locality",
        "columns"=>["street", "postalcode", "locality"]
      },
      "response"=>
       {"suggestions"=>
         [
           {"street"=>"Kungs Barkarö Kyrka", "postalcode"=>"73693", "locality"=>"Kungsör"},
           {"street"=>"Kungs Norrby", "postalcode"=>"59028", "locality"=>"Borensberg"},
           {"street"=>"Kungs-Husby Ryttesta", "postalcode"=>"74599", "locality"=>"Enköping"}
         ]
       }
    }
    allow(HTTParty).to receive(:get).and_return(response)

    result = PostnummerserviceClient.suggest_address(lookup_street: "Kungs")
    raise 'fail test on purpose to test ci'
    expect(result).to eq(response)
  end

  it "raises an error" do
    allow(HTTParty).to receive(:get).and_raise(HTTParty::ResponseError.new("Error!"))
    expect { PostnummerserviceClient.suggest_address(lookup_street: "foo") }.to raise_error(PostnummerserviceClient::Exception)
  end
end

describe PostnummerserviceClient, ".suggest_zip_code_and_city" do
  it "returns zip code and city suggestions based on a whole/partial zip code" do
    response = {
      "name"=>"Valid API",
      "type"=>"Address suggestions",
      "version"=>"11.45",
      "encoding"=>"utf-8",
      "options"=> {
        "api_key"=>"my very secret api key",
        "suggest"=>"postalcode",
        "lang"=>"se",
        "charset"=>"utf-8",
        "response_format"=>"json",
        "max_rows"=>20,
        "cols"=>"street,postalcode,locality",
        "columns"=>["street", "postalcode", "locality"]
      },
      "response"=>
       {"suggestions"=>
         [
           {"postalcode"=>"12305", "locality"=>"Farsta"},
           {"postalcode"=>"12320", "locality"=>"Farsta"},
           {"postalcode"=>"12321", "locality"=>"Farsta"},
         ]
       }
    }
    allow(HTTParty).to receive(:get).and_return(response)

    result = PostnummerserviceClient.suggest_zip_code_and_city(lookup_zip_code: "123")
    expect(result).to eq(response)
  end

  it "raises an error if there is a connectivity issue" do
    allow(HTTParty).to receive(:get).and_raise(HTTParty::ResponseError.new("Error!"))
    expect { PostnummerserviceClient.suggest_zip_code_and_city(lookup_zip_code: "123") }.to raise_error(PostnummerserviceClient::Exception)
  end
end

describe PostnummerserviceClient, ".suggest_city" do
  it "returns city suggestions based on a whole/partial city" do
    response = {
      "name"=>"Valid API",
      "type"=>"Address suggestions",
      "version"=>"11.45",
      "encoding"=>"utf-8",
      "options"=> {
        "api_key"=>"my very secret api key",
        "suggest"=>"postalcode",
        "lang"=>"se",
        "charset"=>"utf-8",
        "response_format"=>"json",
        "max_rows"=>20,
        "cols"=>"street,postalcode,locality",
        "columns"=>["street", "postalcode", "locality"]
      },
      "response"=>
       {"suggestions"=>
         [
           {"locality"=>"Kungsgården"},
           {"locality"=>"Kungshamn"},
           {"locality"=>"Kungsängen"},
         ]
       }
    }
    allow(HTTParty).to receive(:get).and_return(response)

    result = PostnummerserviceClient.suggest_city(lookup_city: "Kungs")
    expect(result).to eq(response)
  end

  it "raises and error if there is a connectivity issue" do
    allow(HTTParty).to receive(:get).and_raise(HTTParty::ResponseError.new("Error!"))
    expect { PostnummerserviceClient.suggest_city(lookup_city: "Kungs") }.to raise_error(PostnummerserviceClient::Exception)
  end
end
