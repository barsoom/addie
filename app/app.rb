require "honeybadger"

module Addie
  class App < Padrino::Application
    get "/" do
      "hello world"
    end

    get "/boom" do
      raise "Sinatra has left the building"
    end
  end
end
