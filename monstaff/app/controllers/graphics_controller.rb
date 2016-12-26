class GraphicsController < ApplicationController
  include GraphicsHelper
  include UserHelper
require 'date'

def transport_event_new
  if group_permission_url
  perm = params[:transport]


  if perm.nil?

else
@perm =  TransportEvent.new(:transportname => perm[:transportname], :event_start => perm[:event_start], :start_time => perm[:time_start], :end_time => perm[:time_end], :text => perm[:text])
if @perm.save
redirect_to graphics_path
else

redirect_to transport_path
 end
end
else
redirect_to root_path
  end
end

def xlss
if group_permission_url
  if params[:from_date] == nil and params[:to_date] == nil
    #redirect_to user_index_path
  else
    @from = params[:from_date]
    @to = params[:to_date]

end
weekend = User.all.includes(:graphic).where(:graphics => {:date => "--- \'#{@from}\'\n".."--- \'#{@to}\'\n"})

@weekend = []

weekend.each do |col|
  
  col.graphic.each do |col2|
    @weekend << {:name => col.fullname, :phone => col.phone, :date => col2.date, :region => col.region.name}
      
      end
end
@weekend = @weekend.sort_by {|date| date[:date]}.group_by {|date| date[:date]}
else
redirect_to root_path
  end
end

def month


@u = User.select("fullname").where(region_id: (params[:region])).map(&:fullname)

@date = params[:date] ? Date.parse(params[:date]) : Date.today
@g = Graphic.where(engname: @u)
@graphics_by_date = @g.group_by(&:date)
end
def show
end
def index

 respond_to do |format|
if params[:date] == nil
@date = DateTime.now.to_date

else
@date = Date.parse(params[:date])
end
@transport_event = TransportEvent.where(:event_start => [@date.prev_day, @date, @date.next])
@hash = User.all.includes(:graphic).where(:graphics => {:date =>  @date.to_s}).group_by(&:region)
format.html 
format.js
#on { render :json => @hash}
end

end



def create
a = params[:graphics]



if a[:date].length == '10'
@graphics = Graphic.new(params.require(:graphics).permit(:engname, :date, :comment, :worktime))


else
@graphics = Graphic.new(params.require(:graphics).permit(:engname, :date, :comment, :worktime))
@graphics.datevalidate!
ab = a[:date].split(",")
@user = User.find_by_fullname(a[:engname])

ab.each do |date|

@graphics = @user.graphic.create(:engname => a[:engname], :date => date, :worktime => a[:worktime], :comment => a[:comment])


end
end

#begin

if  @graphics.save
#flash[:success] = "task added"
redirect_to graphics_path
else

render 'new'

end

end
def new


#if  ['admin','eng'].include? (current_user.group.name)

if group_permission_url
@graphics = Graphic.new

else
redirect_to graphics_path
end

  end

def destroy
@graph = Graphic.find(params[:id])
@graph.destroy
#redirect_to user_index_path
redirect_to request.referrer
end


end
