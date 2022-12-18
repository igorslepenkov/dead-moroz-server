class MorozBoardPolicy < ApplicationPolicy
  def info?
    user.dead_moroz?
  end

  def elves?
    user.dead_moroz?
  end

  def children?
    user.dead_moroz?
  end
end
