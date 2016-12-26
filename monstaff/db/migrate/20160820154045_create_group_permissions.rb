class CreateGroupPermissions < ActiveRecord::Migration
  def change
    create_table :group_permissions do |t|

t.string :read
t.string :write
t.string :remove
t.string :group_id
t.string :url_path

      t.timestamps
    end
  end
end
