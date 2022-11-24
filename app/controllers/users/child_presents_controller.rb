class Users::ChildPresentsController < ApplicationController
  before_action :set_user

  def create
    @user.child_presents.build(child_presents_params[:child_presents])

    if @user.save
      render json: @user.child_presents, status: :ok
    else
      render json: { message: 'Errors have occured', errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def child_presents_params
    params.permit(child_presents: %i[name image])
  end
end
