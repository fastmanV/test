class CreateUserPermissions < ActiveRecord::Migration
  def change
    create_table :user_permissions do |t|
t.string :read
t.string :write
t.string :remove
t.string :user_id
t.string :region_id
      t.timestamps
    end
  end
end
