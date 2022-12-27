class MorozBoardController < ApplicationController
  def info
    authorize User, policy_class: MorozBoardPolicy

    children_count = User.children.count
    children_with_reviews_count = User.children.joins(child_profile: [:child_reviews]).count
    elves_count = User.elves.count
    elves_invited_count = User.elves.where.not(invitation_sent_at: nil).count
    elves_registered_count = User.elves.where.not(invitation_accepted_at: nil).count
    elves_not_registered_count = User.elves.where.not(invitation_sent_at: nil).where(invitation_accepted_at: nil).count

    render json: { elves: { count: elves_count,
                            invited: elves_invited_count,
                            accepted_invitation: elves_registered_count,
                            not_accepted_invitation: elves_not_registered_count },
                   children: { count: children_count, with_review_count: children_with_reviews_count,
                               without_review_count: children_count - children_with_reviews_count } }
  end

  def elves
    authorize User, policy_class: MorozBoardPolicy

    page, sort_type, filter_type, sort_order, limit = elves_index_params.values_at(:page,
                                                                                   :sort_type,
                                                                                   :filter_type,
                                                                                   :sort_order,
                                                                                   :limit)

    render ElvesServices::ElvesListingService.call(page, sort_type, filter_type, sort_order, limit)
  end

  private

  def elves_index_params
    params.permit(:page, :sort_type, :filter_type, :sort_order, :limit)
  end
end
