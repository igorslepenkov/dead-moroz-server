class Users::ChildReviewsController < ApplicationController
  before_action :set_user

  def create
    child_profile = User.children.find(create_params[:child_id]).child_profile
    child_review = ChildReview.new(user: @user, child_profile:, score: create_params[:score],
                                   comment: create_params[:comment])
    if child_review.save
      render json: { child_review: }, status: :created
    else
      render json: { message: 'Errors occured', errors: child_review.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Errors occured', errors: ['Child with provided id was not found'] }, status: :bad_request
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_params
    params.require(:review).permit(:child_id, :score, :comment)
  end
end
