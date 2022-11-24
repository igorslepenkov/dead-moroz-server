class CreateChildPresents < ActiveRecord::Migration[7.0]
  def change
    create_table :child_presents do |t|
      t.string :name
      t.string :image
      t.timestamps
    end

    add_belongs_to :child_presents, :user
  end
end
