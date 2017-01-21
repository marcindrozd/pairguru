require "rails_helper"

describe MovieDetailsImporter do
  describe "#call" do
    context "when movie is found" do
      before do
        stub_request(:get, /api.themoviedb.org\/3\/search\/movie/).
          with(:headers => {'Connection'=>'close', 'Host'=>'api.themoviedb.org', 'User-Agent'=>'http.rb/2.1.0'}).
          to_return(status: 200, body: stubbed_response, headers: {})
      end

      it "returns movie details (poster_url, average_rating and overview) in form of a struct" do
        movie = MovieDetailsImporter.new.call("Pulp Fiction")

        expect(movie).to be_an_instance_of(OpenStruct)
        expect(movie.poster_url).to eq("http://image.tmdb.org/t/p/w185/dM2w364MScsjFf8pfMbaWUcWrR.jpg")
        expect(movie.average_rating).to eq(8.1)
        expect(movie.overview).to eq("A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a "\
          "washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories "\
          "that ingeniously trip back and forth in time.")
      end
    end

    context "when no movie is found" do
      before do
        stub_request(:get, /api.themoviedb.org\/3\/search\/movie/).
          with(:headers => {'Connection'=>'close', 'Host'=>'api.themoviedb.org', 'User-Agent'=>'http.rb/2.1.0'}).
          to_return(status: 200, body: no_movie_found_response, headers: {})
      end

      it "returns struct with default poster_url, average_rating and overview" do
        movie = MovieDetailsImporter.new.call("Not existing movie")

        expect(movie).to be_an_instance_of(OpenStruct)
        expect(movie.poster_url).to include("http://lorempixel.com/185/278/abstract")
        expect(movie.average_rating).to eq("n/a")
        expect(movie.overview).to eq("Movie details were not found.")
      end
    end
  end

  def stubbed_response
    "{\"page\":1,\"results\":[{\"poster_path\":\"\\/dM2w364MScsjFf8pfMbaWUcWrR.jpg\",\"adult\":false,"\
    "\"overview\":\"A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a "\
    "washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories "\
    "that ingeniously trip back and forth in time.\",\"release_date\":\"1994-10-13\",\"genre_ids\":[53,80],"\
    "\"id\":680,\"original_title\":\"Pulp Fiction\",\"original_language\":\"en\",\"title\":\"Pulp Fiction\","\
    "\"backdrop_path\":\"\\/mte63qJaVnoxkkXbHkdFujBnBgd.jpg\",\"popularity\":6.835713,\"vote_count\":5463,"\
    "\"video\":false,\"vote_average\":8.1}],\"total_results\":1,\"total_pages\":1}"
  end

  def no_movie_found_response
    "{\"page\":1,\"results\":[],\"total_results\":0,\"total_pages\":1}"
  end
end
