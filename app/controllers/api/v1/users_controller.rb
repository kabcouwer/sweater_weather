class Api::V1::UsersController < ApplicationController
  def create
    # binding.pry
    render json: { error: 'Json content type required' }, status: :bad_request and return if request.content_type != 'application/json' && request.format.json? != true

    body = JSON.parse(request.raw_post, symbolize_names: true)
    if body[:password] == body[:password_confirmation]
      user = User.new(user_params)
      if user.save
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
