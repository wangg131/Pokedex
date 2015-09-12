class PokedexController < ApplicationController

  POKESEARCH = "http://pokeapi.co/api/v1/pokemon/"

  def search_query
    begin
      @number = params[:id]
      response = HTTParty.get(POKESEARCH + "#{@number}")
      data = fetching_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
    render json: data.as_json, code: code
  end

  def search_form #search
    @number = params[:id]
  end

  def fetching_data(response)
    pokemon_types = response.fetch("types").map { |type| { name: type.fetch("name") }}
    pokemon_descriptions = response.fetch("descriptions").map { |description| { resource_uri: description.fetch("resource_uri") }}
    pokemon_evolutions = response.fetch("evolutions").map do |evolution|
      {
        level: evolution.fetch("level"),
        method: evolution.fetch("method"),
        to: evolution.fetch("to")
      }
      end
    pokemon_sprite = response.fetch("sprites").map { |sprite| { resource_uri: sprite.fetch("resource_uri") }}

    return {
      name: response.fetch("name"),
      id: response.fetch("national_id"),
      types: pokemon_types,
      description: pokemon_descriptions.first,
      evolutions: pokemon_evolutions,
      sprites: pokemon_sprite
      }
  end

end
