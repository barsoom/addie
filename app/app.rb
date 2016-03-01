module Addie
  class App < Padrino::Application
    get "/" do
      %{<a href="/api/v1/lookup?street=Kung&country_code=SE">Address lookup</a> service, see more at <a href="https://github.com/barsoom/addie">https://github.com/barsoom/addie</a>.}
    end

    get "/revision" do
      ENV.fetch("GIT_COMMIT")
    end

    get "/boom" do
      raise "Sinatra has left the building"
    end

    get "/api/v1/lookup" do
      LookUpAddress.call(
        street: params.fetch("street"),
        country_code: params.fetch("country_code"),
      ).to_json
    end

    get "/api/v1/validate" do
      {
        valid: true,
        message: "",
      }.to_json
    end
  end
end
