module Api
  module V1
    class MoviesController < Api::V1::ApiController
      def index
        render json: Movie.all, each_serializer: BasicMovieSerializer
      end

      def show
        render json: Movie.find(params[:id]), serializer: BasicMovieSerializer
      end
    end
  end
end
