class Api::V1::SessionsController < ApplicationController
  def create
    render json: { error: 'Json content type required' }, status: :bad_request and return if request.content_type != 'application/json' && request.format.json? != true

    body = JSON.parse(request.raw_post, symbolize_names: true)
    found_user = User.find_by(email: body[:email])
    
    if found_user && found_user.authenticate(body[:password])
      render json: UsersSerializer.new(found_user), status: :ok
    else
      render json: { errors: 'Sorry, your credentials are invalid. Try Again.' }, status: :bad_request
    end
  end
end
