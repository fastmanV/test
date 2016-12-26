class CreateLoggs < ActiveRecord::Migration
  def change
    create_table :loggs do |t|
t.string :username
t.text :text_event
      t.timestamps
    end
  end
end
