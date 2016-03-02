module Addie
  class ValidateAddress
    method_object [ :street!, :zip_code!, :city!, :country_code! ]

    def call
      {
        valid: true,
        message: "",
      }
    end
  end
end
