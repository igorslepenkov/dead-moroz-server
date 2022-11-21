class AddAvatarToChildProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :child_profiles, :avatar, :string
  end
end
