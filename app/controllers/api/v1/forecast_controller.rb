class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present?
      lat, lon = MapquestFacade.coordinates(params[:location])
      current, daily, hourly = OpenWeatherFacade.all_weather(lat, lon)

      render json: ForecastSerializer.weather(current, daily[0..4], hourly[0..7])
    else
      render json: { error: 'need city and state'}, status: :bad_request
    end
  end
end
