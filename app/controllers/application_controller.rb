class ApplicationController < ActionController::API
  def bad_request(errors)
    render json: { errors: errors },
           status: :bad_request
  end

  def password_mismatch_error
    render json: { error: 'Please send email and matching password and password_confirmation' },
           status: :unprocessable_entity
  end
end
