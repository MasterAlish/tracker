Tracker::Application.routes.draw do

  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  resources :users
  resources :clients
  match '/tickets/add_property', to: 'tickets#add_property'
  match '/tickets/change_state', to: 'tickets#change_state'
  match '/tickets/roadmap', to: 'tickets#roadmap'
  match '/tickets/search', to: 'tickets#search', via: :post
  resources :tickets
  match '/tasks/helper', to: 'tasks#helper'
  resources :tasks, only: [:new,:create,:update]
  resources :comments, only: [:create, :destroy]
  resources :attachments
  match '/comments/update', to: 'comments#update'

  root :to => 'tickets#roadmap'
  match '/text/markup', to: 'text#markup', via: :post

  match '/mails/refresh', to: 'mail_threads#refresh'
  match '/mails/remove_mail', to: 'mail_threads#remove_mail', via: :post
  match '/mails/remove_thread', to: 'mail_threads#remove_thread', via: :post
  match '/mails/compose', to: 'mail_threads#compose', via: :post
  match '/mails/edit', to: 'mail_threads#edit', via: :post
  match '/mails/deliver', to: 'mail_threads#deliver', via: :post

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
