# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, :find_store

  before_action :configure_sign_in_params, only: [:create]

  def company_identify
  end

  def company_identify_action
    company = Company.where("id LIKE(?)", "%#{params[:company_id]}%").first
    if company
      if Rails.env.development?
        redirect_to "http://#{company.subdomain}.localhost:3000#{admin_login_path}"
      else
        redirect_to "https://www.shopperscloud-dev.com#{admin_login_path}"
      end
    else
      if Rails.env.development?
        redirect_to root_path
      else
        redirect_to "https://www.shopperscloud-dev.com"
      end
      flash[:danger] = "該当する法人IDがありません"
    end
  end

  def after_login
    redirect_to root_path unless admin_signed_in?
  end

  # def after_sign_in_path_for(resource)
  # end

  # def after_sign_out_path_for(resource)
  # end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    # set_flash_message!(:danger, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if Rails.env.development?
      redirect_to admins_path
    else
      redirect_to "https://www.shopperscloud-dev.com#{admins_path}"
    end
    create_log(action_type="login")
  end

  # DELETE /resource/sign_out
  def destroy
    create_log(action_type="logout")
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    if Rails.env.development?
      redirect_to "http://localhost:3000"
    else
      redirect_to "https://www.shopperscloud-dev.com"
    end
  end

  protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:staff_id])
    end

  private

    # Create log each login and logout action
    def create_log(action_type)
      LoginLog.create(
        staff_id: current_admin.staff_id,
        full_name: current_admin.full_name,
        ip_address: request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip,
        action_type: action_type,
        action_time: DateTime.current
      )
    end
end
