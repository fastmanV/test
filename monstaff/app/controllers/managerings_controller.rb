class ManageringsController < ApplicationController
require 'net/telnet'
include UserHelper

def gwip(ip)
first = ip.rpartition('.').last
last = ip.gsub(/#{first}/, "1")
	return last
end



def operation(switch)

	

if /DES-|D-Link/.match(switch[:model])

switchobj = Telnet.new
@switchobj = switchobj.dowloadcfg(switch, "upload")
file_path = "/home/tftp/#{switch[:ip]}.cfg"


oldvlan = File.open(file_path).grep(/System vlan/)[0].split(" ")[4]
radiuskey = File.open(file_path).grep(/radius port 1812 key/)[0].split(" ")[9]
full_path_to_read = File.expand_path(file_path)
full_path_to_write = File.expand_path("/home/tftp/#{switch[:ip]}_new.cfg")

oldgw = gwip(switch[:ip])
newgw = gwip(switch[:newip])

newvlan = "System vlan" + " " + switch[:newvlan]

File.open(full_path_to_read) { |source_file|
  contents = source_file.read
  contents.gsub!(/#{switch[:ip]}/, switch[:newip])
  contents.gsub!(/#{oldgw}/, newgw)
  contents.gsub!(/System vlan #{oldvlan}/, newvlan)
contents.gsub!(/#{radiuskey}/, switch[:radius])
  File.open(full_path_to_write, "w+") { |f| f.write(contents) }
}

@switchobj = switchobj.dowloadcfg(switch, "download")
elsif /Layer2+|ECS3510-28T/.match (switch[:model])

		switchobj = Telnet.new
@switchobj = switchobj.dowloadcfg(switch, "upload")
sleep(300)
@switchobj = switchobj.dowloadcfg(switch, "download")
newswitch = {:ip => switch[:newip]}
@switchobj = switchobj.dowloadcfg(newswitch, "huy")
elsif /FoxGate/.match(switch[:model])

	switchobj = Telnet.new
@switchobj = switchobj.dowloadcfg(switch, "upload")
elsif /ROS/.match(switch[:model])

	switchobj = Telnet.new
@switchobj = switchobj.dowloadcfg(switch, "upload")

elsif /24-port/.match(switch[:model])
	switchobj = Telnet.new
@switchobj = switchobj.dowloadcfg(switch, "upload")
	file_path = "/home/tftp/#{switch[:ip]}_linksys"
oldgw = gwip(switch[:ip])
newgw = gwip(switch[:newip])

oldvlan = "interface vlan" + " " + switch[:oldvlan]
radiuskey = File.open(file_path).grep(/radius-server/)[0].split(" ")
#puts oldvlan
oldvlan = "interface vlan" + " " + switch[:oldvlan]
full_path_to_read = File.expand_path(file_path)
full_path_to_write = File.expand_path("/home/tftp/#{switch[:ip]}_new")
newvlan = "interface vlan" + " " + switch[:newvlan]

gw = "ip default-gateway" + " " + newgw
radius = switch[:newip]
newip = "ip address" + " " + switch[:newip]
File.open(full_path_to_read) { |source_file|


  contents = source_file.read

  
  contents.gsub!(/ip default-gateway #{oldgw}/, gw)
  contents.gsub!(/source #{radiuskey[7]}/, radius)
contents.gsub!(/#{radiuskey[4]}/, switch[:radius])
contents.gsub!(/#{oldvlan}/, newvlan)
  contents.gsub!(/ip address #{switch[:ip]}/, newip)

  File.open(full_path_to_write, "w+") { |f| f.write(contents) }
}
@switchobj = switchobj.dowloadcfg(switch, "download")
	
	end
	
end



	def index
if group_permission_url
		if params[:mngsw] != nil
		@some = params[:mngsw]
ip = @some[:old_ip]
newvlan = @some[:new_vlan]
new_ip = @some[:new_ip].to_s
new_radius = "#{@some[:new_radius]}"
oldvlan = @some[:old_vlan]
t = Telnet.new
model = t.swmodel(ip)
vers = t.swvers(ip)


@switch = {:ip => ip, :model => model, :vers => vers, :newip => new_ip, :newvlan => newvlan, :radius => new_radius, :oldvlan => oldvlan}

operation(@switch)

log = Logg.new(:username => current_user.fullname, :text_event => "#{ip} - изменение ip ")
log.save!



	respond_to do  |format|
    format.html
    format.js
  end

	end
else
redirect_to graphics_path
#render 'error'
end

end
end
