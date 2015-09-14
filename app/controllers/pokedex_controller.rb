class PokedexController < ApplicationController

  POKE_URI = "http://pokeapi.co"

  def search_query
    begin
      response = HTTParty.get(POKE_URI + "/api/v1/pokemon/" + params[:id])
      data = fetching_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
    render json: data.as_json, code: code
  end

  def search_form; end

  private

# lines 22 - 34 is the start of incorporating the ability to seach for Pokemon by name. Not yet finished.
  def get_number(name)
    pokemon_list = HTTParty.get(POKE_URI + "/v1/pokedex/")["objects"][0]["pokemon"]
    pokemon_list.each do |pokemon_entry|
      if name.downcase == pokemon_entry["name"]
        pokemon_entry["resource_uri"]
        return pokemon_entry["resource_uri"]
      end
    end
  end

  def get_pokemon_by_name(name)
    HTTParty.get(POKE_URI + get_number(name))
  end

  def fetching_data(response)
    pokemon_types = response.fetch("types").map { |type| { name: type.fetch("name") }}
    access_description = response.fetch("descriptions").map { |description| { resource_uri: description.fetch("resource_uri") }}
    pokemon_description = HTTParty.get(POKE_URI + access_description.first[:resource_uri])
    access_sprite = response.fetch("sprites").map { |sprite| { resource_uri: sprite.fetch("resource_uri") }}
    pokemon_sprite = HTTParty.get(POKE_URI + access_sprite.first[:resource_uri])

    # If the pokemon has two types, include both types. This conditional was necessary or
    # else the Pokedex would throw an error if the pokemon only had a single type due to an undefined second type
    if pokemon_types[1]
      response = {
        name: response.fetch("name"),
        id: response.fetch("national_id"),
        type1: pokemon_types[0][:name],
        type2: pokemon_types[1][:name],
        description: pokemon_description["description"],
        sprite: pokemon_sprite["image"]
        }
    # If it only has one type, only include that one.
    else
      response = {
        name: response.fetch("name"),
        id: response.fetch("national_id"),
        type1: pokemon_types[0][:name],
        description: pokemon_description["description"],
        sprite: pokemon_sprite["image"]
        }
    end
    return response
  end

end
