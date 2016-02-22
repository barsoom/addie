module Addie
  class LookupAddress
    method_object [ :street!, :country_code! ]

    class FakeLookup
      def self.lookup(street:, country_code:)
        [
          { street: "Kungsgatan 321", zipCode: "12345", city: "Norrby" }
        ]
      end
    end

    class NullService
      def self.lookup(street:, country_code:)
        []
      end
    end

    LOOKUP_SERVICES_BY_COUNTRY_CODE = {
      "SE" => PostnummerserviceClient,
      "TEST" => FakeLookup,
    }

    def call
      suggestions = LOOKUP_SERVICES_BY_COUNTRY_CODE.
        fetch(country_code, NullService).
        lookup(street: street, country_code: country_code)

      {
        suggestions: suggestions
      }
    end
  end
end
