class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


        helper_method :current_user
        #helper_method :group_permission_url

before_filter :require_login, :except=>[:login]

private
def require_login

if current_user == nil
@user = User.new
render "user/login"
end
end


private

def current_user
begin
@current_user ||= User.find(session[:user_id]) if session[:user_id]
rescue
@current_user = nil
end
end

end
