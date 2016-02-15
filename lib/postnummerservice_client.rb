require "active_support"
require "active_support/core_ext/object"
require "attr_extras"
require "httparty"

# API documentation: http://www.postnummerservice.se/files/uploads/webshop_attachment/13/valid_api_dokumentation.pdf
class PostnummerserviceClient
  class Exception < StandardError; end

  RETURN_ATTRIBUTES_FOR_STREET_SUGGESTIONS   = "street,postalcode,locality"
  RETURN_ATTRIBUTES_FOR_ZIP_CODE_SUGGESTIONS = "postalcode,locality"

  def self.suggest_address(lookup_street:, opts: {})
    new.suggest_address(lookup_street: lookup_street, opts: opts)
  end

  def self.suggest_zip_code_and_city(lookup_zip_code:, opts: {})
    new.suggest_zip_code_and_city(lookup_zip_code: lookup_zip_code, opts: opts)
  end

  def self.suggest_city(lookup_city:)
    new.suggest_city(lookup_city: lookup_city)
  end

  def suggest_address(lookup_street:, opts: {})
    return_attributes = opts.fetch(:return_attributes, RETURN_ATTRIBUTES_FOR_STREET_SUGGESTIONS)
    zip_code = opts.fetch(:zip_code, nil)
    city = opts.fetch(:city, nil)

    search_options = SearchParams.new(q: lookup_street,
      cols:       return_attributes,
      postalcode: zip_code,
      locality:   city,
    )

    postnummerservice_lookup(suggestion_type: "street", search_params: search_options.to_param)
  end

  def suggest_zip_code_and_city(lookup_zip_code:, opts: {})
    return_attributes = opts.fetch(:return_attributes, RETURN_ATTRIBUTES_FOR_ZIP_CODE_SUGGESTIONS)
    city = opts.fetch(:city, nil)

    search_options = SearchParams.new(q: lookup_zip_code,
      cols:       return_attributes,
      locality:   city,
    )

    postnummerservice_lookup(suggestion_type: "postalcode", search_params: search_options.to_param)
  end

  def suggest_city(lookup_city:)
    search_options = SearchParams.new(q: lookup_city)

    postnummerservice_lookup(suggestion_type: "locality", search_params: search_options.to_param)
  end

  private

  def postnummerservice_lookup(suggestion_type:, search_params:)
    # This is just a guess, but we need to disable the SSL verification due to that postnummerservice uses a weak (SHA-1) cert?
    # We 'hardcode' the response format, since we only want json back (supported formats are json, xml and text).
    url = "https://valid.postnummerservice.se/#{api_version}/api/suggest/#{suggestion_type}/?api_key=#{api_key}&response_format=json&#{search_params}"
    HTTParty.get(url,verify: false)

  rescue HTTParty::ResponseError => e
    raise PostnummerserviceClient::Exception.new("Connectivity issues? Error message: #{e.message}")
  end

  def api_key
    ENV.fetch("POSTNUMMERSERVICE_API_KEY", :missing_api_key)
  end

  def api_version
    "11.45"
  end

  class PostnummerserviceClient::SearchParams
    # Params:
    #   q                    - search question (street or zip code or city)
    #   cols                 - choose which return information we want back (street, postalcode, locality)
    #   postalcode           - limit the selection by restricting to part of a zip code
    #   locality             - limit the selection by restricting to part of the locality
    #
    #   auctionet vs postnummerservice
    #
    #   street   : street
    #   zip code : postalcode
    #   city     : locality

    vattr_initialize [:q!, :cols, :postalcode, :locality]

    def to_param
      instance_values.map { |param_name, value|
        "#{param_name}=#{value}" if value
      }.compact.join("&")
    end
  end
end
