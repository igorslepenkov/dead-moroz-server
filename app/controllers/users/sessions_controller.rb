class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:create]

  private

  def respond_with(resource, _opts = {})
    render json: { user: resource, message: 'You are logged in.' }, include: { child_profile: { include: :child_presents } },
           status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Nothing happened.' }, status: :unauthorized
  end
end
