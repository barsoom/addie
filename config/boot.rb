# Defines our constants
RACK_ENV = ENV["RACK_ENV"] ||= "development" unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path("../..", __FILE__) unless defined?(PADRINO_ROOT)

# Disable honeybadger messages in test
ENV["HONEYBADGER_LOGGING_LEVEL"] = "error" if RACK_ENV == "test"

# Load our dependencies
require "bundler/setup"
Bundler.require(:default, RACK_ENV)

# Add paths to padrino autoloading/reloading
Padrino.dependency_paths << Padrino.root("app/services/**/*.rb")
Padrino.dependency_paths << Padrino.root("lib/**/*.rb")

Dotenv.load
Padrino.load!
