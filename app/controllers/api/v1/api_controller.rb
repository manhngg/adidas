class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      @api_key = ApiKey.find_by(key_value: decoded[:api_key])
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: e.message}, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {errors: e.message}, status: :unauthorized
    end
  end
end
