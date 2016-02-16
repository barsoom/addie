require "rack/cors"
require_relative "config/boot"

# Set up Cross-Origin Resource Sharing (CORS) rules. (https://github.com/cyu/rack-cors)
allowed_origin_urls = ENV.fetch("ALLOWED_ORIGIN_URLS")

use Rack::Cors do
  allow do
    origins *allowed_origin_urls.split

    resource "/"
  end
end

# We use Padrino to get code reloading in dev.
run Padrino.application
