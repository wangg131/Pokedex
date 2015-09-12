class PokedexController < ApplicationController

  POKESEARCH = "http://pokeapi.co/api/v1/pokemon/"

  def index
    begin
      @number = params[:pokemon]
      response = HTTParty.get(POKESEARCH + "6")
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
    return {
      name: response.fetch("name"),
      types: response.fetch("types").map do |type|
          { name: type.fetch("name") }
      end
    }
  end
end
