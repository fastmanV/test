class CreateTelnets < ActiveRecord::Migration
  def change
    create_table :telnets do |t|

      t.timestamps null: false
    end
  end
end
