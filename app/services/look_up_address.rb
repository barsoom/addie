module Addie
  class LookUpAddress
    method_object [ :street!, :country_code! ]

    class FakeLookUp
      def self.look_up(street:, country_code:)
        [
          { street: "Kungsgatan 321", zipCode: "12345", city: "Norrby" }
        ]
      end
    end

    class NullService
      def self.look_up(street:, country_code:)
        []
      end
    end

    LOOK_UP_SERVICES_BY_COUNTRY_CODE = {
      "SE" => PostnummerserviceClient,
      "TEST" => FakeLookUp,
    }

    def call
      suggestions = LOOK_UP_SERVICES_BY_COUNTRY_CODE.
        fetch(country_code, NullService).
        look_up(street: street, country_code: country_code)

      {
        suggestions: suggestions
      }
    end
  end
end
