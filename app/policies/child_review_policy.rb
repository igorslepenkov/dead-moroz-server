class ChildReviewPolicy < ApplicationPolicy
  def create?
    !user.child?
  end

  def destroy?
    (user.id == record.user_id) || user.dead_moroz?
  end
end
