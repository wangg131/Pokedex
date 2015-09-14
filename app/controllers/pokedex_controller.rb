class PokedexController < ApplicationController

  POKE_URI = "http://pokeapi.co"

  def search_query
    begin
      response = HTTParty.get(POKE_URI + "/api/v1/pokemon/" + params[:id]) #change to name
      data = fetching_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
    render json: data.as_json, code: code
  end

  def search_form; end

  def fetching_data(response)
    #pokemon_types = response.fetch("types").map { |type| { name: type.fetch("name") }}
    access_description = response.fetch("descriptions").map { |description| { resource_uri: description.fetch("resource_uri") }}
    pokemon_description = HTTParty.get(POKE_URI + access_description.first[:resource_uri])
    access_sprite = response.fetch("sprites").map { |sprite| { resource_uri: sprite.fetch("resource_uri") }}
    pokemon_sprite = HTTParty.get(POKE_URI + access_sprite.first[:resource_uri])
    response = {
      name: response.fetch("name"),
      id: response.fetch("national_id"),
      # type1: pokemon_types[0][:name],
      # type2: pokemon_types[1][:name],
      description: pokemon_description["description"],
      sprite: pokemon_sprite["image"]
      }
    return response
  end

end
