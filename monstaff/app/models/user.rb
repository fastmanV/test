class User < ActiveRecord::Base
  include UserHelper
has_many :graphic, :dependent => :destroy
belongs_to :region
belongs_to :group
has_many :UserPermission
#accepts_nested_attributes_for :UserPermission, allow_destroy: true
attr_accessor :password, :password_confirmation, :pass_valid, :name, :secondname, :reset_pass, :group_perm
before_save :createfullname
before_update :encrypt_password, :reset_password
validates :name, :presence => { :message => "Поле имя не может быть пустым"}, :on => :create
validates :mail , email_format: { :message => "поле почта пустое или содержит недоспустимые символы" }
validates :mail, :uniqueness => {:message => "Такой почтовый ящик уже зарегестрирован."}
#validates  :password, :presence => {:message => "пароль не может быть пустым"},
validates :password,  :format => {:with => /(^[a-zA-Z]\w{3,16}$)/, :message => "пароль должен состоять из букв и 
цифр", :allow_blank => false },
#                  :confirmation => true,
                   :length => { :within => 6..30 , message: "пароль должен быть минимум 6 символов" }, :on => :update, :if => :should_validate_password?

validate :vacation

validates :region_id , :presence =>  { :message => "Выберите ЦОА"}


def should_validate_password?

pass_valid != '1'
end


def vacation
if vacstart.present? and vacend.present?
true
else
self.vacstart = nil
self.vacend = nil
end
end
def encrypt_password
	
  if password.present?
self.passactive = "1"
#self.group_id = "1"
    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)  

	end
  end

def clear_password
  self.password = nil
end


def self.authenticate (login="", passwd="")


user = User.find_by_mail(login)
if user
if user.passactive != nil

if user && user.match_password(passwd)
return user
else
return false
	end
else

if user
return user
else
return false
        end


end
else
false
end
end

def match_password(password="")
   encrypted_password == BCrypt::Engine.hash_secret(password, salt)
end



def full_name
    "#{fullname} (#{region})"
  end


def validate!
    errors.add(:mail, "Проверьте правильность введенных данных") if mail.blank? or password.blank?
#self.valid?
#self.errors[attribute_name].blank?
  end

def find_permission


end

def self.search(search, region)



 if search
#includes(:region).where(region:.where('users.fullname LIKE :search OR regions.name LIKE :search OR users.mail LIKE :search', search: "%#{search}%").references(:region)
where(:region => (region)).includes(:region).where('users.fullname LIKE :search OR regions.name LIKE :search OR users.mail LIKE :search', search: "%#{search}%").references(:region)
  #includes(:region).where('users.fullname LIKE :search OR regions.name LIKE :search OR users.mail LIKE :search', search: "%#{search}%").references(:region)
  else
   #all
   where(region: region)
 end
end


def userfio(fullname)
str = fullname

res = str.split(' ', 2)

name = res[0]
last = res[1].split(' ').map(&:chr).join(".") unless res[1] == nil

return "#{name} #{last}."

end


def createfullname
if name.present? and secondname.present?
self.fullname = secondname + " " + name
end
end

def reset_password
if reset_pass == '1'
self.passactive = nil
end
end
end
