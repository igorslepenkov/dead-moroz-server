class CreateChildReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :child_reviews do |t|
      t.integer :score
      t.text :comment
      t.timestamps
    end

    add_belongs_to :child_reviews, :child_profile
  end
end
