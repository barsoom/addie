module Addie
  class LookupAddress
    method_object [ :street!, :country_code! ]

    class FakeLookup
      def self.lookup(country_code, street)
        [
          { street: "Kungsgatan", zipCode: "12345", city: "Norrby" }
        ]
      end
    end

    class NullService
      def self.lookup(country_code, street)
        []
      end
    end

    LOOKUP_SERVICES_BY_COUNTRY_CODE = {
      "SE" => FakeLookup,
      "TEST" => FakeLookup,
    }

    def call
      suggestions = LOOKUP_SERVICES_BY_COUNTRY_CODE.
        fetch(country_code, NullService).
        lookup(country_code, street)

      {
        suggestions: suggestions
      }
    end
  end
end
