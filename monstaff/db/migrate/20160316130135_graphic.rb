class Graphic < ActiveRecord::Migration
  def change
  create_table :graphics do |t|
t.string :engname
t.string :worktime
t.text :comment
t.string :date
t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end


  end
end
