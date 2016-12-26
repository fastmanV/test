class Group < ActiveRecord::Base
has_many :users
has_many :GroupPermission
validates :name, uniqueness: { message: "Такая группа уже существует" }
#attr_accessor :super
end
