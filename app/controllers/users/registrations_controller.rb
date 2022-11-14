class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'We have sent you email verififcation. Please follow instructions from this email.' }
  end

  def register_failed
    render json: { message: 'Something went wrong.' }
  end
end
