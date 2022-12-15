class ChildProfilePolicy < ApplicationPolicy
  def index?
    !user.child?
  end

  def show?
    !user.child?
  end

  def create?
    user.child?
  end

  def update?
    user.child?
  end
end
