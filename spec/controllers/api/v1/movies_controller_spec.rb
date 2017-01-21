require 'rails_helper'

describe Api::V1::MoviesController do
  describe "GET #index" do
    before do
      3.times { FactoryGirl.create(:movie) }
      get :index
    end

    it { is_expected.to respond_with(200) }

    it "returns json format" do
      expect(response.content_type).to eq("application/json")
    end

    it "returns 3 movie records" do
      movies = JSON.parse(response.body, symbolize_names: true)

      expect(movies.size).to eq(3)
    end

    it "does not contain genre details" do
      movies = JSON.parse(response.body, symbolize_names: true)

      expect(movies.first.has_key?(:genre)).to be false
    end
  end

  describe "GET #show" do
    before do
      3.times { FactoryGirl.create(:movie) }
      searched_movie = FactoryGirl.create(:movie, title: "Star Wars")

      get :show, id: searched_movie.id
    end

    it { is_expected.to respond_with(200) }

    it "returns json format" do
      expect(response.content_type).to eq("application/json")
    end

    it "returns the movie that was requested" do
      movie = JSON.parse(response.body, symbolize_names: true)

      expect(movie[:title]).to eq("Star Wars")
    end

    it "does not contain genre details" do
      movie = JSON.parse(response.body, symbolize_names: true)

      expect(movie.has_key?(:genre)).to be false
    end
  end
end
