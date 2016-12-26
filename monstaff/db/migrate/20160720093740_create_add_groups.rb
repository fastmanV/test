class CreateAddGroups < ActiveRecord::Migration
  def up
add_column :users, :group_id, :integer
  end

def down
remove_column :users,  :group
remove_column :users,  :region
end
end
