# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # skip_before_action :verify_authenticity_token, :find_store

  before_action :configure_sign_in_params, only: [:create]

  def company_identify
  end

  def company_identify_action
    company = Company.where("id LIKE(?)", "%#{params[:company_id]}%").first
    if company
      redirect_to admin_login_path
    else
      redirect_to root_path
      flash[:danger] = "該当する法人IDがありません"
    end
  end

  def after_sign_in_path_for(resource)
    admin_panel_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # GET /resource/sign_in
  # def new
  #   if Rails.env.development?
  #     if request.server_name.split(".")[0] == "www" || request.server_name.split(".")[0] == "localhost"
  #       redirect_to company_identify_path
  #     else
  #       super
  #     end
  #   else
  #     super
  #   end
  # end

  # POST /resource/sign_in
  def create
    # self.resource = warden.authenticate!(auth_options)
    # # set_flash_message!(:danger, :signed_in)
    # sign_in(resource_name, resource)
    # yield resource if block_given?
    # redirect_to root_path
    super
    create_log(action_type="login")
  end

  # DELETE /resource/sign_out
  def destroy
    create_log(action_type="logout")
    super
    # signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # set_flash_message! :notice, :signed_out if signed_out
    # yield if block_given?
    # redirect_to company_identify_path
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
