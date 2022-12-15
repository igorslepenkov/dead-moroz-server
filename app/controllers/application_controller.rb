class ApplicationController < ActionController::API
  include Pundit::Authorization
  include ActionController::MimeResponds
  respond_to :json

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
  end
end
