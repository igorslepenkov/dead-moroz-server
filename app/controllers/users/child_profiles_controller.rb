class Users::ChildProfilesController < ApplicationController
  before_action :set_user, only: %i[create update]

  def index
    render ChildProfilesServices::ChildProfilesListingService.call(child_profiles_index_params[:page],
                                                                   child_profiles_index_params[:sort_type],
                                                                   child_profiles_index_params[:sort_order],
                                                                   child_profiles_index_params[:limit])
  end

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
    return unless params[:id]

    @user = User.find(params[:id])
  end

  def child_profile_params
    params.require(:child_profile).permit(:country, :city, :hobbies, :birthdate, :past_year_description,
                                          :good_deeds, :avatar)
  end

  def child_profiles_index_params
    params.permit(:page, :sort_type, :sort_order, :limit)
  end
end
