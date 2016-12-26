class Graphic < ActiveRecord::Base
belongs_to :user
belongs_to :region
serialize :date
validates :date, :presence => { :message => "поле дата не может быть пустым"}
validates :date, :uniqueness => {:scope => :engname, :message => "Сотрудник уже работает в этот день", :allow_blank => true}
validates :worktime, :presence => { :message => "поле рабочие часы не может быть пустым"}
validate :comment_string

def comment_string
if  self.comment.length > 15
if self.comment.match(/\s/) or self.comment.blank?
true
else
  errors.add(:comment, "Строка комментрий не содержит пробелов")

end
#elsif self.comment.blank?
#errors.add(:comment, "Строка комментрий пустая")
end
end

def self.search(query)
    where("engname like ?", "%#{query}%")
  end

def datevalidate!
    errors.add(:error, "Проверьте правильность введенных данных") if date.blank?
#self.valid?
#self.errors[attribute_name].blank?
  end


def userfio(fullname)
str = fullname

res = str.split(' ', 2)

name = res[0]
last = res[1].split(' ').map(&:chr).join(".") unless res[1] == nil

return "#{name} #{last}."

end


end
