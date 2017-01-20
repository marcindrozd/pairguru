class AdvancedMovieSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :genre, serializer: GenreSerializer
end
