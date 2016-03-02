class PostnummerserviceClient
  static_facade :look_up,
    [ :street!, :country_code, :endpoint ]

  def look_up
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
