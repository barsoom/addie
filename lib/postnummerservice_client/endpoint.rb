# API documentation: http://www.postnummerservice.se/files/uploads/webshop_attachment/13/valid_api_dokumentation.pdf
class PostnummerserviceClient
  class Endpoint
    def suggest_by_street(street)
      HTTParty.get(
        URI.escape("https://valid.postnummerservice.se/13.05/api/suggest/street?api_key=#{api_key}&response_format=json&q=#{street}&cols=street,postalcode,locality"),
        verify: false,
      ).deep_symbolize_keys
    end

    private

    def api_key
      ENV.fetch("POSTNUMMERSERVICE_API_KEY")
    end
  end
end
