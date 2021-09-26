class Api::V1::ForecastController < ApplicationController
  def index
    coord = MapquestFacade.coordinates(params[:location])
    data = OpenWeatherFacade.all_weather(coord[:lat], coord[:lng])

    render json: ForecastSerializer.weather(data)
  end
end
