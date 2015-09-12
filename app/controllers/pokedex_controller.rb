class PokedexController < ApplicationController

  POKESEARCH = "http://pokeapi.co/api/v1/pokemon/"

  def search #results
    begin
      @number = params[:id]
      response = HTTParty.get(POKESEARCH + "16")
      data = fetching_data(response)
      code = :ok
    rescue
      data = {}
      code = :no_content
    end
    render json: data.as_json, code: code
  end

  # def search
  #   @number = params[:id]
  # end

  def fetching_data(response)
    types = response.fetch("types").map { |type| { name: type.fetch("name") }}
    descriptions = response.fetch("descriptions").map { |description| { name: description.fetch("name") }}
    evolutions = response.fetch("evolutions").map do |evolution|
      {
        level: evolution.fetch("level"),
        method: evolution.fetch("method"),
        to: evolution.fetch("to")
      }
      end

    return {
      name: response.fetch("name"),
      id: response.fetch("national_id"),
      types: types,
      description: descriptions,
      evolutions: evolutions
      }
  end

end
