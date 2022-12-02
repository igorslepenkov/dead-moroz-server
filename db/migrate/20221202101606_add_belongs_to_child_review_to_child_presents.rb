class AddBelongsToChildReviewToChildPresents < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :child_presents, :child_review
  end
end
