class Api::V1::ProductsController < ApplicationController
  include SerializableUrl

  before_action :authorize_request
  before_action :find_store, only: :index

  def index
    @products = @store.products
    if products.present?
      render json: set_url(products, "Api::V1::Products::Index::ProductSerializer"), status: 200
    else
      render json: {message: "不正なエラー"}, status: 500
    end
  end

  private

  attr_reader :store, :products

  def find_store
    @store = Store.find_by id: params[:store_id]
    render json: {message: "店舗が見つかりません"}, status: 404 unless store
  end
end
