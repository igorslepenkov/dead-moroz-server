class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    client_domain = Rails.env.production? ? Rails.application.credentials.client_domain_prod : Rails.application.credentials.client_domain_dev

    if resource.errors.empty?
      redirect_to "#{Rails.application.credentials.client_domain_dev}?confirmation=success"
    else
      redirect_to "#{Rails.application.credentials.client_domain_dev}?confirmation=error&error=#{resource.errors.full_messages[0]}"
    end
  end
end
