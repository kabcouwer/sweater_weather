class Api::V1::UsersController < ApplicationController
  def create
    unless request.content_type == 'application/json'
      bad_request('Json content type required') and return
    end

    body = JSON.parse(request.raw_post, symbolize_names: true)
    
    if body[:password] == body[:password_confirmation]
      user = User.new(user_params)
      if user.save
        render json: UsersSerializer.new(user), status: :created
      else
        bad_request(user.errors.full_messages)
      end
    else
      password_mismatch_error
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
