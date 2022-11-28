class Users::ChildProfilesController < ApplicationController
  before_action :set_user, only: %i[create update]

  def index
    page = child_profiles_index_params[:page]
    sort_type = child_profiles_index_params[:sort_type] || Constants::USER_SORTINGS[:All]
    sort_order = child_profiles_index_params[:sort_order] || Constants::USER_SORTINGS_ORDERS[:DESC]
    limit = child_profiles_index_params[:limit] || 10

    @children = User.children

    case sort_type
    when Constants::USER_SORTINGS[:All]
      case sort_order
      when Constants::USER_SORTINGS_ORDERS[:ASC]
        children_to_render = @children.order('name ASC').page(page).per(limit)
        render json: { children: children_to_render,
                       page:,
                       total_pages: children_to_render.total_pages,
                       total_records: children_to_render.count,
                       limit: },
               include: ['child_profile'],
               status: :ok
      when Constants::USER_SORTINGS_ORDERS[:DESC]
        children_to_render = @children.order('name DESC').page(page).per(limit)
        render json: { children: children_to_render,
                       page:,
                       total_pages: children_to_render.total_pages,
                       total_records: children_to_render.count,
                       limit: },

               include: ['child_profile'],
               status: :ok
      end
    end
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
