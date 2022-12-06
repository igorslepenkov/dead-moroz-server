class ChildPresentsController < ApplicationController
  before_action :set_user

  def create
    @child_profile.child_presents.build(child_present_params['0'])

    if @child_profile.save
      render json: @child_profile.child_presents, status: :ok
    else
      render json: { message: 'Errors have occured', errors: @child_profile.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @present = @child_profile.child_presents.find(params[:id])

    if @present.destroy
      render json: { message: 'Present deleted', child_presents: @child_profile.child_presents }, status: :ok
    else
      render json: { message: 'Something happend, present is not deleted' }, status: :bad_request
    end
  end

  private

  def set_user
    @child_profile = ChildProfile.find(params[:child_profile_id])
    @user = User.where(id: params[:user_id]) || @child_profile.user
  end

  def child_present_params
    params.require(:child_present).permit("0": %i[name image])
  end
end
