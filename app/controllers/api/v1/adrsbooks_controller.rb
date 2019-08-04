class Api::V1::AdrsbooksController < ApplicationController
  before_action :authorize_request
  before_action :find_store, only: :index

	# GET /api/v1/adrsbooks
  def index
    @categories = Adrsbook::CATEGORY
  end

  private

  def find_store
    @store = Store.find_by id: params[:store_id]
    render json: {message: "店舗が見つかりません"}, status: 404 unless @store
  end
end
