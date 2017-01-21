class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  expose_decorated(:movies) { Movie.all }
  expose(:movie)
  expose(:movie_details) { movie ? MovieDetailsImporter.new.call(movie.title) : NullMovie.new.details }

  def send_info
    MovieInfoMailerJob.perform_async(current_user, movie)
    redirect_to :back, notice: 'Email sent with movie info'
  end

  def export
    MovieExporterJob.perform_async(current_user)
    redirect_to root_path, notice: 'Movies exported'
  end
end
