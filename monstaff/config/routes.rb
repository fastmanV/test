Rails.application.routes.draw do
  
   root 'graphics#index'
get 'faq' => 'main#faq'
post 'region' => 'user#region'
get 'region' => 'user#region'
post 'groups' => 'user#group'
get 'groups' => 'user#group'
get 'xlss' => 'graphics#xlss'
post 'xlss' => 'graphics#xlss'
get 'transport' => 'graphics#transport_event_new'
post 'transport' => 'graphics#transport_event_new'
put '/user/:id(.:format)', to: 'user#shortupdate', as: 'shortupdate'
post 'RegDel' => 'user#RegDel'
get 'RegDel' => 'user#RegDel'
post 'permission' => 'user#permission'
get 'permission' => 'user#permission'
post 'user_permission' => 'user#permission'

get 'trol' => 'topology#trololo'
post 'trol' => 'topology#trololo'

get 'topology' => 'topology#index'
post 'topology' => 'topology#index'

post 'managerings' => 'managerings#index'
get 'managerings' => 'managerings#index'


get 'user_permission' => 'user#permission'
get 'group_permission' => 'user#group_permission'
post 'group_permission' => 'user#group_permission' 

post 'controll' => 'user#controll'
get 'controll' => 'user#controll'

get 'user/login' => 'user#login'
post 'user/login' => 'user#login'
get 'user/vacation' => 'user#vacation'
post 'user/vacation' => 'user#vacation'
get 'graphics/month' => 'graphics#month'
post 'graphics/month' => 'graphics#month'
get 'logout' => 'user#logout'
post 'logout' => 'user#logout'
resources :user

resources :graphics


#resources :region

end
