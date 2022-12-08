class Users::ChildPresentsController < ApplicationController
  before_action :set_user

  def create
    @user.child_presents.build(child_present_params['0'])

    if @user.save
      render json: @user.child_presents, status: :ok
    else
      render json: { message: 'Errors have occured', errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def delete
    @present = @user.child_presents.find(params[:present_id])

    if @present.destroy
      render json: { message: 'Present deleted', child_presents: @user.child_presents }, status: :ok
    else
      render json: { message: 'Something happend, present is not deleted' }, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def child_present_params
    params.require(:child_present).permit("0": %i[name image])
  end
end
