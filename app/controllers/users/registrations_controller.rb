class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

  before_action :extend_sign_up_params, only: :create

  def create_child_profile
    user = User.find(params[:id])
    user.create_child_profile(params[:child_profile])
    if user.save
      render json: { user: }
    else
      render json: { message: 'Errors have occured', errors: user.errors.full_messages }
    end
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed(resource.errors.full_messages)
  end

  def register_success
    render json: { message: 'We have sent you email verififcation. Please follow instructions from this email.' }
  end

  def register_failed(resource_errors)
    if resource_errors
      render json: { message: 'Errors have occured', errors: resource_errors }, status: :bad_request
    else
      render json: { message: 'Something went wrong.' }
    end
  end

  def extend_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def create_child_profile_params
    devise_parameter_sanitizer.permit(:create_child_profile, keys: %i[id child_profile])
  end
end
