class ChGroups < ActiveRecord::Migration
    def up
add_column :groups, :super, :string
  end

def down
remove_column :groups,  :type
#remove_column :users,  :region
end

end
