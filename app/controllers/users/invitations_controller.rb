class Users::InvitationsController < Devise::InvitationsController
  before_action :extend_invitation_params, only: :create

  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      invitation_success
    else
      invitation_failed(resource.errors.full_messages)
    end
  end

  def update
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      accepting_invitation_success
    else
      accepting_invitation_failed(resource.errors.full_messages)
    end
  end

  private

  def accepting_invitation_success
    render json: { message: 'Invitation accepted successfuly. You now may log in' }
  end

  def accepting_invitation_failed(resource_errors)
    if resource_errors
      render json: { message: 'Errors have occured', errors: resource_errors }, status: :bad_request
    else
      render json: { message: 'Something went wrong.' }
    end
  end

  def invitation_success
    render json: { message: 'Invitation successfuly sent' }, status: :ok
  end

  def invitation_failed(resource_errors)
    if resource_errors
      render json: { message: 'Errors have occured', errors: resource_errors }, status: :bad_request
    else
      render json: { message: 'Something went wrong.' }
    end
  end

  def extend_invitation_params
    devise_parameter_sanitizer.permit(:invite, keys: %i[name role])
  end
end
