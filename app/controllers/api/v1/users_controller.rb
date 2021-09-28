class Api::V1::UsersController < ApplicationController
  def create
    render json: { error: 'Json content type required' }, status: :bad_request and return if request.content_type != 'application/json'

    body = JSON.parse(request.raw_post)
    if body['password'] == body['password_confirmation']
      user = User.new(user_params)
      if user.save
        user.api_keys.create!(token: SecureRandom.hex)
        render json: UsersSerializer.new(user), status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :bad_request
      end
    else
      render json: { error: 'Please send email and matching password and password_confirmation' }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
