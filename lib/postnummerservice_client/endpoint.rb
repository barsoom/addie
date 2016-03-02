# API documentation: http://www.postnummerservice.se/files/uploads/webshop_attachment/13/valid_api_dokumentation.pdf
class PostnummerserviceClient
  class Endpoint
    def suggest_by_street(street)
      escaped_street = URI.escape(street)
      HTTParty.get(
        "https://valid.postnummerservice.se/13.05/api/suggest/street?api_key=#{api_key}&response_format=json&q=#{escaped_street}&cols=street,postalcode,locality&max_rows=#{max_rows}", verify: false
      ).deep_symbolize_keys
    end

    private

    def api_key
      key = ENV.fetch("POSTNUMMERSERVICE_API_KEY")
      URI.escape(key)
    end

    def max_rows
      ENV.fetch("POSTNUMMERSERVICE_MAX_RESULTS", 20)
    end
  end
end
