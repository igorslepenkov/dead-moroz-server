class ChangeUserReferenceToProfileReferenceForPresents < ActiveRecord::Migration[7.0]
  def change
    add_reference :child_presents, :child_profile
  end
end
