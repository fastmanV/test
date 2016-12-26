class UserController < ApplicationController

include UserHelper






def permission

perm = params[:permission] || params[:perm]
@check = UserPermission.find_by(user_id: perm[:u_id], region_id: perm[:reg_id])
if @check.nil?
@perm =  UserPermission.new(:read => perm[:read], :write => perm[:write], :remove => perm[:remove], :user_id => perm[:u_id], :region_id => perm[:reg_id])
@perm.save
else
@check.update(:read => perm[:read], :write => perm[:write], :remove => perm[:remove])
 end

 respond_to do |format|
format.html 
format.js
 end
end

def group
@group = Group.new
if request.post?
@group = Group.new(params.require(:group).permit(:name, :super))
@group.save
respond_to do |format|

format.html

format.js
 end
  end


end

def group_permission

perm = params[:group_permission]
@check = GroupPermission.find_by(url_path: perm[:url_path], group_id: perm[:group_id])
if @check.nil?
@perm =  GroupPermission.new(:read => perm[:read], :write => perm[:write], :remove => perm[:remove], url_path: perm[:url_path], group_id: perm[:group_id])
@perm.save
else
@check.update(:read => perm[:read], :write => perm[:write], :remove => perm[:remove])
 end

 respond_to do |format|
format.html 
format.js
 end

end


def controll
  if group_permission_url
@region = Region.all
@regionNew = Region.new
@group = Group.all
@groupNew = Group.new
else
redirect_to graphics_path
  end
end


def region

@region = Region.new
if request.post?
@region = Region.new(params.require(:region).permit(:name))
@region.save
respond_to do |format|

format.html 

format.js 
 end
  end
end

def RegDel
@region = Region.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to controll_path }
      format.js
    end

end

def vacation
@vacation = User.where('vacstart IS NOT NULL')
end

def new

  if group_permission_url

@user = User.new
else
redirect_to graphics_path
end

end

def edit
if params[:update] == '1'
@user = userfind
@region = Region.all
@perm = UserPermission.find_by_id(@user.id)
respond_to do |format|
format.html 
format.js
 end


else
@user = userfind
check = user_find_permission.find {|user| user[:region_id] == @user.region_id}
if check != nil

case check[:acces]
when 'full'
@user = userfind
 @region = Region.all
@perm = UserPermission.find_by_id(@user.id)

when 'rw', 'r'
  @user = userfind
 @region = Region.all
@perm = UserPermission.find_by_id(@user.id)
else

redirect_to graphics_path
end
else
  @user = User.find(current_user.id)
   @region = Region.all
@perm = UserPermission.find_by_id(@user.id)

end
end
end


def show
  begin
  user = userfind
region = user_find_permission.map {|region_id| region_id[:region_id] unless region_id[:acces] == 'deny'}

if  region.include? (user.region_id) or user == current_user

@user = user
else
render 'error'
end
rescue
render 'error'
end
end



def index
if group_permission_url
 region = user_find_permission.map {|region_id| region_id[:region_id] unless region_id[:acces] == 'deny'}
@user = User.search(params[:search], region)

respond_to do |rep|
rep.html
rep.js
  end
else
redirect_to graphics_path
end

end


def create
@user = User.new(params.require(:user).permit(:name, :secondname, :phone, :mail, :region_id))
if  @user.save

redirect_to graphics_path
else

render 'new'
end
end

def update
@user = userfind
@user_list = @user
if @user.update(user_params)

    redirect_to user_path(@user)
  else

case user_params[:pass_valid]

when "1"

else
render "login"
end
end
end



def shortupdate
@user = userfind
@user_list = @user
if @user.update(user_params)
  else
case user_params[:pass_valid]

when "1"
else

end

respond_to do |format|
format.html
format.js
end

end
end


def destroy
    @user = userfind
    @user.destroy
respond_to do |destr|
destr.html
destr.js
end

  end


def login
@user = User.new
@users = session[:user_id]
  if request.post?

     @user = User.new(login_params)

@user.validate!


      user = User.authenticate(@user.mail, @user.password)
                      if user

 session[:user_id] = user.id
case user.passactive
when nil
redirect_to  user_login_path

else
redirect_to  graphics_path

end

      else
      end
     end
end



def logout
    session[:user_id] = nil
redirect_to request.referrer
 end


private

def userfind
User.find(params[:id])
end

def login_params
params.require(:user).permit(:mail, :password)
end


 def user_params

params.require(:user).permit(:fullname, :secondname, :phone, :mail, :password, :group_id, :pass_valid,
:password_confirmation, :vacstart, :vacend, :reset_pass, :region_id)
        end


end
