class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    body = JSON.parse(request.raw_post, symbolize_names: true)
    time = MapquestFacade.route(body[:origin], body[:destination])
    if time != 'impossible'
      trip_time = TimeHelper.length_of_trip(time)
      weather = get_weather_poro(body[:destination], trip_time)
      render json: RoadTripSerializer.route(body[:origin], body[:destination], time, weather)
    else
      render json: RoadTripSerializer.impossible(body[:origin], body[:destination], time)
    end
  end

  private
  def authenticate
    authenticate_user_with_token || handle_bad_authentication
  end

  def authenticate_user_with_token
    body = JSON.parse(request.raw_post, symbolize_names: true)
    @user ||= User.get_user_by_key(body[:api_key])
  end

  def handle_bad_authentication
    render json: { error: 'Bad credentials' }, status: :unauthorized
  end

  def get_weather_poro(location, trip_time)
    lat, lon = MapquestFacade.coordinates(location)
    OpenWeatherFacade.destination_weather(lat, lon, trip_time)
  end
end
