class Api::V1::AuthenticationsController < ApplicationController
  attr_reader :user

  skip_before_action :verify_authenticity_token
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by staff_id: params[:staff_id]
    if user && user.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: {message: "Success!", token: token}, status: 200
    else
      render json: {error: "失敗レスポンス"}, status: 401
    end
  end
end
