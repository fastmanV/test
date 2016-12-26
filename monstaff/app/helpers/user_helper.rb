module UserHelper


def show_vacation(vacation)

@vacation = []
vacation.each do |vac|
if Date.today.between?(Date.parse(vac.vacstart), Date.parse(vac.vacend))

@vacation << {:region => vac.region.name, :username => vac.fullname}

end
end
return @vacation.group_by{|k,v| k[:region]}
end

def select_user_list
if current_user.group.super == '1'
User.all.collect{|u| [u.fullname, u.fullname]}

else
users = user_find_permission.map {|u| 
if u[:acces] == 'full' or u[:acces] == '110'
u[:region_id]
else
end
}
users << current_user.region_id
User.where(region_id: users).collect{|u| [u.fullname, u.fullname]}

end
end


def user_find_permission

@permission = []
if current_user.group.super == '1'
Region.all.each do |id|

@permission << {:acces => 'full', :region_id => id.id}
end

	else
user = current_user.UserPermission.flat_map {|w| [w.read + w.write + w.remove, w.region_id]}
user.each_slice(2) do |rule, region_id|

case rule
when '111'
	acces = 'full'

when '110'
acces = 'rw'
when '100'
acces = 'r'

else
	acces = 'deny'
	end
@permission << {:acces => acces, :region_id => region_id.to_i}

end

end
return @permission
end








def group_permission_url
  #request.original_url
 
if current_user.group.GroupPermission.map {|e| e.url_path}.include? (request.original_url)
 # if current_user.group.GroupPermission.url_path == request.original_url
#true

current_user.group.GroupPermission.map {|e| if [e.read, e.write, e.remove].include? (1)
true
else
false
end
}

elsif current_user.group.super == '1'
  true
else
false
end
end





def link_to_permission(path, name)
if current_user.group.super.to_i == 1

	res = link_to name, path
	
	else	
	#res =false
end

return res
end


def link_to_delete(path, name)
if current_user.group.super.to_i == 1

	res = link_to name, path, method: :delete,data: { confirm: 'Вы уверены?' }
	
	#elsif 

	else
	#res =false
end

return res
end


def user_can_del
if current_user.group.super.to_i == 1

	true
else
	false

end
end

def select_user_permission(path, name)

end

end
