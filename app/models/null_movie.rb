class NullMovie
  def details
    OpenStruct.new(
      overview: "Movie details were not found.",
      poster_url: "http://lorempixel.com/185/278/abstract?a=" + SecureRandom.uuid,
      average_rating: "n/a"
    )
  end
end
