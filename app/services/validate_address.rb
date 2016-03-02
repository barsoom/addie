module Addie
  class ValidateAddress
    method_object [ :street!, :zip_code!, :city!, :country_code! ]

    def call
      if valid_address?
        { status: "valid" }
      else
        { status: "invalid" }
      end
    end

    private

    def valid_address?
      suggestions.map { |suggestion|
        suggestion.
        fetch(:zipCode)
      }.include?(zip_code)
    end

    def suggestions
      LookUpAddress.call(
        street: street,
        country_code: country_code
      ).fetch(:suggestions)
    end
  end
end
