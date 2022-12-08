class ChildReviewsController < ApplicationController
  before_action :set_child_profile

  def create
    user = User.find_by(id: create_params[:user_id])

    @child_profile.child_reviews.build(user:, child_profile: @child_profile, score: create_params[:score],
                                       comment: create_params[:comment])

    if @child_profile.save
      render json: @child_profile.child_reviews, status: :created
    else
      render json: { message: 'Errors occured', errors: @child_profile.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    review = @child_profile.child_reviews.find(params[:id])

    if review.destroy
      render json: @child_profile.child_reviews, status: :ok
    else
      render json: { message: 'Something happend, review is not deleted' }, status: :bad_request
    end
  end

  private

  def set_child_profile
    @child_profile = ChildProfile.find(params[:child_profile_id])
  end

  def create_params
    params.require(:child_review).permit(:score, :comment, :user_id)
  end
end
