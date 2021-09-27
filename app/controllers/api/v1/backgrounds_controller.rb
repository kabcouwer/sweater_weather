class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      image = UnsplashFacade.picture(params[:location])
      
      render json: BackgroundSerializer.background(image)
    else
      render json: { error: 'city and state is required' }, status: :bad_request
    end
  end
end
