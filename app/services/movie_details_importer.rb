class MovieDetailsImporter
  def call(title)
    movie = get_movie(title)
    prepare_movie_details(movie)
  end

  private

  def get_movie(title)
    encoded_title = CGI.escape(title)
    response = HTTP.get(
      "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&query=#{encoded_title}&page=1&include_adult=false"
    )
    JSON.parse(response)["results"].first
  end

  def prepare_movie_details(movie)
    OpenStruct.new(
      overview: movie["overview"],
      poster_url: "http://image.tmdb.org/t/p/w185#{movie["poster_path"]}",
      average_rating: movie["vote_average"]
    )
  end
end
