class PostnummerserviceClient
  static_facade :lookup,
    [ :street!, :country_code, :endpoint ]

  def lookup
    endpoint.suggest_by_street(street).fetch(:response)
      .fetch(:suggestions).map { |suggestion_line|
      {
        street:  suggestion_line.fetch(:street),
        zipCode: suggestion_line.fetch(:postalcode),
        city:    suggestion_line.fetch(:locality),
      }
    }
  end

  private

  def endpoint
    @endpoint || Endpoint.new
  end
end
