class ChangeTransport < ActiveRecord::Migration
   def up
add_column :transport_events, :start_time , :string
add_column :transport_events, :end_time , :string
  end

def down
remove_column :transport_events, :event_end
#remove_column :users,  :region
end

end
