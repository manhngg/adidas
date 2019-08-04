class HealthchecksController < ApplicationController
  def index
    render json: {message: "Active!"}, status: 200
  end
end
