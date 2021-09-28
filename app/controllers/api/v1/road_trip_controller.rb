class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    render status: :ok
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
end
