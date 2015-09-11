class PokedexController < ApplicationController

  POKESEARCH = "http://pokeapi.co/api/v1/pokemon/"

  def index
    begin
      @number = params[:id]
      response = HTTParty.get(POKESEARCH + "55")
      data = fetching_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
    render json: data.as_json, code: code

  end

  def show; end

  def fetching_data(response)
          # response2 = Pokegem.get "pokemon", 25
    pokemons = response.fetch, {}
    pokemons.map do |pokemon|
      {
        name: pokemon.fetch("name", ""),
        national_id: pokemon.fetch("national_id", ""),
        types: pokemon.fetch("types", []),
          #@type = response["types"]
          #@type.each do |type_hash|
            #@type_array.push(type_hash["name"])
            #@type_array
        descriptions: pokemon.fetch("name", []),
          # first hash["resource_uri"] >> ["description"].. can just chain it?
        evolutions: pokemon.fetch("evolutions", [])
          # level:
          # to:
      }
    end
  end
end
#
# r = HTTParty.get("http://pokeapi.co/api/v1/pokedex/1")
# => {"created"=>"2013-11-09T15:14:48.957604",
#  "modified"=>"2013-11-09T15:14:48.957565",
#  "name"=>"national",
#  "pokemon"=>
#[{"name"=>"golduck_gen_1",
#   pokemon_list = r["pokemon"]....[{"name"=>"rattata",
