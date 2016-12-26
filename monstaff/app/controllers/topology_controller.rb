class TopologyController < ApplicationController
require 'thread'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'rubygems'
require 'mechanize'

def rebuild

pool = params[:pool]
vlan = params[:vlan]
sys = %x[sudo ruby /home/fastman/FASTMAN/ruby/topology/topologymake.rb '#{pool}' '#{vlan}']


# Detach the spawned process
# => Process.detach(process)

@some = {:id => pool}

respond_to do  |format|

 
    format.html
    format.json {render json: @some}
  end
end


def fping(pool)

count = 0
arr = []
result = []
254.times do |i|

  arr[i] = Thread.new {
    sleep(rand(0)/10.0)
        if i < 2
else
        ip = "#{pool}" + i.to_s

#Thread.current["mycount"] = " "
a = %x[ping -c1 "#{ip}" | grep "received" | awk '{print ($4)}'].chomp
end
if a == '1'

result << ip
count += 1
end
   

  }


end
arr.each {|t| t.join;}
return result

end


def index
 
    

ringslist = ActiveRecord::Base.connection.execute("show tables in topology like '172_%';")
@rings = []
ringslist.each do |res|
@rings << res[0]
end

@rings = @rings.group_by {|word| word[4..6] }
if params[:ring] == nil
@ring = "Feed monkey"
else
@ter = params[:ring]

#ring = ActiveRecord::Base.connection.execute("select t1.ip, tpport,  t2.ip from 
#arp.#{@ter.to_s} as t1 LEFT JOIN topology.#{@ter.to_s} as t2;")
ring = ActiveRecord::Base.connection.execute("select t1.ip, tpport, t2.ip, port25, port26, 
port27, port28, max_value from arp.#{@ter.to_s} as t1 LEFT JOIN topology.#{@ter.to_s} as t2 
on t1.ip = t2.ip where t1.ip not like '%.1';")
switch = ActiveRecord::Base.connection.execute("select ip from arp.#{@ter.to_s};")

###
@status = []
switch.each do |ip|


status = %x[ping -c1 -W 2 "#{ip[0]}" | grep "received" | awk '{print ($4)}'].chomp

@status << {:ip => ip[0], :status => status}

  end


agent2 = Mechanize.new{|a| a.ssl_version, a.verify_mode = 'TLSv1',  OpenSSL::SSL::VERIFY_NONE}
#page = agent2.get('https://api-devel.o3.ua/app_dev.php/v1/login')
#page = agent2.post('https://api-devel.o3.ua/app_dev.php/v1/login', {
page = agent2.post('https://api.o3.ua/v1/login', {
  "username" => "topology",
  "password" => "test123"
})


 #page


token =  JSON.parse(page.body)
#ring = "172.17.11"
token = token["token"]
hash =  Mechanize.new{|a| a.ssl_version, a.verify_mode = 'SSLv3', OpenSSL::SSL::VERIFY_NONE}

key = hash.get('https://api.o3.ua/v1/getLoc/' + @ter.to_s.gsub(/_/, ".") +'?token=' + token)


@my = JSON.parse(key.body)

@ring = ring.sort{|x,y| y[7].to_i<=>x[7].to_i}

@topology = []
@build = []
@a = []
@ya = []
@ring.each do |res|
  

  @a << {:ip => res[2], :port25 => res[3], :port26 => res[4], :port27 => res[5], :port28 => res[6]}
ips = [res[0]]

s = @ya.find {|tt| tt[:port] == res[1]}
if s == nil
  begin
  mlat = @my["sw_loc"].find {|root| root["ip"] == ips[0] }["lat"]
mlng = @my["sw_loc"].find {|root| root["ip"] ==  ips[0] }["lng"]
rescue
mlat = nil
mlng = nil  
  end
@ya << {:port => res[1] , :ips => ips, :lat => mlat, :lng => mlng}
else
s[:ips].push(res[0])
end
  
  
  
begin
mlat = @my["sw_loc"].find {|root| root["ip"] == res[0] }["lat"]
mlng = @my["sw_loc"].find {|root| root["ip"] ==  res[0] }["lng"]
rescue
mlat = nil
mlng = nil
end
@cords = []
[res[3], res[4], res[5], res[6]].each do |nest|
begin
lat = @my["sw_loc"].find {|root| root["ip"] == nest }["lat"]
lng = @my["sw_loc"].find {|root| root["ip"] == nest }["lng"]
rescue
lat = nil
lng = nil
end
@cords << [lat, lng] unless lat == nil

end

@topology << {:ip => res[0], :lat => mlat, :lng => mlng, :nest => @cords}
@build  << {:ip => res[0], :lat => mlat, :lng => mlng, :nest => @cords}
end
@b = @topology.group_by { |h| h[:lat] }.values.select { |a| a.count > 0}.flatten

@topology2 = []
#@b = @topology.select {|a| a[:nest].count > 0 and a[:lat] == 50.409996}
@topology.uniq {|e| e[:lat]}.each do |sa|
#start uniq

ar =  @build.select {|a|  a[:lat] == sa[:lat]} 

shorips = ar.map{|x| x[:ip]}

@ips = ""
@top = []
@nextsw = []
@link_status = []

shorips.each do |sh|
  begin
sw = @a.find{|ip| ip[:ip] == sh}
@nextsw = @nextsw | [sw[:port25], sw[:port26], sw[:port27] ,sw[:port28]] unless sw == nil
  @top << @a.select{|ip| ip[:ip] == sh}
str = sh.split('.')
@ips = @ips + "," + str[3]
rescue
  end
end

@nested = []
ar.map{|x| x[:nest] }.each do |nest|
  @nested = @nested | nest
  end

@next = @nextsw - shorips
prewsw = @a.find {|ip| [ip[:port25], ip[:port26], ip[:port27], ip[:port28]].include? (shorips[0])}

if prewsw.nil?
  prewsw = {:ip => "tp"}
end
@next1 = @next.reject { |c| c.empty? }
nextstatus = @build.find {|ip| ip[:ip] == @next1[0]}

begin
status = @status.find {|ip| ip[:ip] == nextstatus[:ip] }[:status]
 rescue
  status = nil
    end


  @topology2 << {:ip => @ips[1..-1], :lat => sa[:lat], :lng => sa[:lng], :nest => @nested, :hash => @top, :ips => shorips, :main => prewsw, :next => @next1, :status => status, :all_status => @status}


#end uniq
end

@gontop = {:tp => @my["tp_loc"] , :tp_link => @ya ,:ring => @topology2}
@gonring = @a



#.each do |sa|


#end


respond_to do |ring|
ring.html
ring.js

end
end
end


end
