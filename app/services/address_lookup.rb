module Addie
  class AddressLookup
    method_object [ :street!, :country_code! ]

    def call
      { data: "Norrby!" }
    end
  end
end
