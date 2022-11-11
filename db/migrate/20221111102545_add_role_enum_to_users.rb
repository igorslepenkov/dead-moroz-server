class AddRoleEnumToUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :role, Constants::ROLE

    change_table :users do |t|
      t.enum :role, enum_type: 'role', default: 'child', null: false
    end
  end
end
