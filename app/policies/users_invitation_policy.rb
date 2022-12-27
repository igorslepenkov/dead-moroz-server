class UsersInvitationPolicy < ApplicationPolicy
  def create?
    user.dead_moroz?
  end
end
