class RegToUser < ActiveRecord::Migration
  def up

add_column :users, :region_id, :integer
  end

def down
del_column :users, :region
end
end
