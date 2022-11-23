class Users::ChildProfilesController < ApplicationController
  def create_child_profile
    user = User.find(params[:id])
    user.create_child_profile(create_child_profile_params)
    if user.save
      render json: user, include: ['child_profile'], status: :ok
    else
      render json: { message: 'Errors have occured', errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update_child_profile
    user = User.find(params[:id])
    if user.child_profile.update(update_child_profile_params)
      render json: user, include: ['child_profile'], status: :ok
    else
      render json: { message: 'Errors have occured', errors: user.child_profile.errors.full_messages },
             status: :bad_request
    end
  end

  private

  def create_child_profile_params
    params.require(:create_child_profile).permit(:country, :city, :hobbies, :birthdate, :past_year_description,
                                                 :good_deeds, :avatar)
  end

  def update_child_profile_params
    params.require(:update_child_profile).permit(:country, :city, :hobbies, :birthdate, :past_year_description,
                                                 :good_deeds, :avatar)
  end
end
