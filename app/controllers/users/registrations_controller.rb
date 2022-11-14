class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

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
      render json: { message: 'Errors have occured', errors: resource_errors }
    else
      render json: { message: 'Something went wrong.' }
    end
  end
end
