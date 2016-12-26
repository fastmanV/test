class Region < ActiveRecord::Base
has_many :user
has_many :graphic, :through => :user
validates :name, uniqueness: { message: "Такой регион уже существует" }
end
