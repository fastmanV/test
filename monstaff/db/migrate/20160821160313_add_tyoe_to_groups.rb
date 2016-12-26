class AddTyoeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :type, :string
  end
end
