class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      image = UnsplashFacade.picture(params[:location])

      render json: BackgroundSerializer.background(image)
    else
      bad_request('City and state is required')
    end
  end
end
