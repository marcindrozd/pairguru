module Api
  module V2
    class MoviesController < Api::V2::ApiController
      def index
        render json: Movie.all.includes(:genre), each_serializer: AdvancedMovieSerializer
      end

      def show
        render json: Movie.find(params[:id]), serializer: AdvancedMovieSerializer
      end
    end
  end
end
