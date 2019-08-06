class BaseController < ApplicationController
  before_action :find_store
  before_action :authenticate_admin!

  protect_from_forgery

  # TODO: set login controller
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json {head :forbidden, content_type: 'text/html'}
      format.html {redirect_to root_path, notice: exception.message}
      format.js {head :forbidden, content_type: 'text/html'}
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  # TODO: set current_admin after implemented login function
  # def current_admin
  #   @current_admin ||= Admin.find(1)
  # end

  def find_store
    @store = Store.find_by id: params[:store_id] || (params[controller_path.singularize][:store_id] if
        params[controller_path.singularize]) || (
    params[:q][:store_id] if params[:q])

    return if @store
    redirect_to root_path, notice: "Store not found."
  end
end
