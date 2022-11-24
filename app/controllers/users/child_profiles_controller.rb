class Users::ChildProfilesController < ApplicationController
  before_action :set_user

  def create
    @user.create_child_profile(child_profile_params)
    if @user.save
      render json: @user, include: ['child_profile'], status: :ok
    else
      render json: { message: 'Errors have occured', errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @user.child_profile.update(child_profile_params)
      render json: @user, include: ['child_profile'], status: :ok
    else
      render json: { message: 'Errors have occured', errors: @user.child_profile.errors.full_messages },
             status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def child_profile_params
    params.require(:child_profile).permit(:country, :city, :hobbies, :birthdate, :past_year_description,
                                          :good_deeds, :avatar)
  end
end
