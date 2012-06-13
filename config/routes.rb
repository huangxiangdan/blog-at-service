# -*- encoding : utf-8 -*-
BlogService::Application.routes.draw do
  resources :blog_rsses

  match 'auth/:provider/callback', :to => 'sessions#create'
  match 'weibo', :to => 'sessions#weibo'
  match 'register', :to => 'blog_rsses#index'
end
