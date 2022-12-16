class Users::InvitationsController < Devise::InvitationsController
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

  private

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
end
