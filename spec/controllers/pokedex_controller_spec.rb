require 'rails_helper'

POKEAPI = { cassette_name: "POKEAPI", record: :new_episodes }

RSpec.describe PokedexController, type: :controller do
  describe "interacting with the PokeAPi", vcr: POKEAPI do
    before :each do
      get :search_query, id: "55"
    end

    it "should be successful" do
      expect(response).to be_ok
    end

    it "should return a json response object" do
      expect(response.header['Content-Type']).to include 'application/json'
    end

    context "the returned json object" do
      it "has the right keys" do
        data = JSON.parse response.body

        %w(id).each do |key|
          expect(data.map(&:keys).flatten.uniq).to include key
        end
      end
    end
  end
end
