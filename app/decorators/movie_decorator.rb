class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    'http://lorempixel.com/100/150/' + %W(abstract nightlife transport).sample + '?a=' + SecureRandom.uuid
  end

  def details
    MovieDetailsImporter.new.call(movie.title)
  end
end
