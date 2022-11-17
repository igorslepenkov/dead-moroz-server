class CreateChildProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :child_profiles do |t|
      t.string :country
      t.string :city
      t.datetime :birthdate
      t.text :hobbies
      t.text :past_year_description
      t.text :good_deeds
      t.timestamps
    end

    add_belongs_to :child_profiles, :user
  end
end
