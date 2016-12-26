class CreateTransportEvents < ActiveRecord::Migration
  def change
    create_table :transport_events do |t|
t.string :transportname
t.string :event_start
t.string :event_end
t.text :text

      t.timestamps
    end
  end
end
