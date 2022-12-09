class ChildProfilesController < ApplicationController
  before_action :set_user, except: %i[index]

  def index
    page, sort_type, filter_type, sort_order, limit = child_profiles_index_params.values_at(:page,
                                                                                            :sort_type,
                                                                                            :filter_type,
                                                                                            :sort_order,
                                                                                            :limit)
    render ChildProfilesServices::ChildProfilesListingService.call(page, sort_type, filter_type, sort_order, limit)
  end

  def show
    return unless @user

    render json: @user, include: { child_profile: { include: %i[child_reviews child_presents] } }
  end

  def create
    @user.create_child_profile(child_profile_params)
    if @user.save
      render json: @user, include: { child_profile: { include: :child_presents } }, status: :ok
    else
      render json: { message: 'Errors have occured', errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @user.child_profile.update(child_profile_params)
      render json: @user, include: { child_profile: { include: :child_presents } }, status: :ok
    else
      render json: { message: 'Errors have occured', errors: @user.child_profile.errors.full_messages },
             status: :bad_request
    end
  end

  private

  def set_user
    return unless params[:user_id]

    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'User not found' }, status: :not_found
  end

  def child_profile_params
    params.require(:child_profile).permit(:country, :city, :hobbies, :birthdate, :past_year_description,
                                          :good_deeds, :avatar)
  end

  def child_profiles_index_params
    params.permit(:page, :sort_type, :filter_type, :sort_order, :limit)
  end
end
