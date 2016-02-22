module Addie
  class App < Padrino::Application
    get "/" do
      %{Address lookup service, see more at <a href="https://github.com/barsoom/addie">https://github.com/barsoom/addie</a>}
    end

    get "/api/v1/lookup" do
      LookupAddress.call(
        street: params.fetch("street"),
        country_code: params.fetch("country_code"),
      ).to_json
    end

    get "/revision" do
      ENV.fetch("GIT_COMMIT")
    end

    get "/boom" do
      raise "Sinatra has left the building"
    end
  end
end
