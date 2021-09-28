class Api::V1::SessionsController < ApplicationController
  def create
    unless request.content_type == 'application/json'
      bad_request('Json content type required') and return
    end

    body = JSON.parse(request.raw_post, symbolize_names: true)
    found_user = User.find_by(email: body[:email])

    if found_user && found_user.authenticate(body[:password])
      render json: UsersSerializer.new(found_user), status: :ok
    else
      bad_request('Sorry, your credentials are invalid. Try Again.')
    end
  end
end
