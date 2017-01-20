module Api
  module V1
    class MoviesController < Api::V1::ApiController
      def index
        render json: Movie.all
      end

      def show
        render json: Movie.find(params[:id])
      end
    end
  end
end
