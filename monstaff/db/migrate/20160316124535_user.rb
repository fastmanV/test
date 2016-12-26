class User < ActiveRecord::Migration
  def change
create_table :users do |t|
t.string :fullname
t.string :salt
t.string :encrypted_password
t.string :passactive
t.string :group
t.string :region
t.string :phone
t.string :mail
t.string :vacstart
t.string :vacend
end

  end
end
