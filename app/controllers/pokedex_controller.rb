class PokedexController < ApplicationController

  POKESEARCH = "http://pokeapi.co/api/v1/pokemon/"

  def index
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

  def show; end

  def fetching_data(response)
    pokemons = response.fetch "pokemons", {}
    pokemons.map do |pokemon|
      {
        name: pokemon["name"]
      }
    end
  end
end
