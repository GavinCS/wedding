Gavinandcarolene::Application.routes.draw do

  resources :index
  get "admin", :to   => 'admin/admin#index', :as => 'admin'
  get "admin/:id/show"    => 'admin/admin#show'
  get "admin/users/edit"    => 'admin/admin#edit'
  get "admin/users/new"    => 'admin/admin#new'
  get 'admin/sign_in' => 'admin/admin#sign_in'


  #resources admin :guests
  get 'admin/guests/', :to => 'admin/guest_accounts#index', :as => 'guests'
  get 'admin/guests/addresses', :to => 'admin/guest_accounts#addresses', :as => 'addresses'
  get 'admin/guests/addresses/:id/address', :to => 'admin/guest_accounts#show_address', :as => 'address'
  get 'admin/guests/:id/profile', :to => 'admin/guest_accounts#show', :as  => 'guest_show'
  get 'admin/guests/:id/edit', :to => 'admin/guest_accounts#edit', :as  => 'guest_edit'
  get 'admin/guests/communicate', :to => 'admin/guest_accounts#communicate', :as => 'guests_communicate'
  get 'admin/guests/ajax-get-guests', :to => 'admin/guest_accounts#ajax_get_guests', :as => 'ajax_get_guests'
  post 'admin/guests/send_email', :to => 'admin/guest_accounts#send_email'
  get 'admin/guests/new', :to => 'admin/guest_accounts#new'    , :as => 'guests_new'
  post 'admin/guests/'  , :to => 'admin/guest_accounts#create'
  patch 'admin/guests/:id/update'  , :to => 'admin/guest_accounts#update', :as => 'guest'
  post 'admin/guests/import'  , :to => 'admin/guest_accounts#import'
  get 'admin/guests/address/new', :to => 'admin/guest_accounts#new_address', :as => 'new_address'
  post 'admin/guests/address/create', :to => 'admin/guest_accounts#create_address'


  #resources :guests
  get 'guests/:id/register', :to => 'guests#register', :as  => 'guests_register'
  get 'guests/:id/rsvp', :to => 'guests#rsvp', :as  => 'guests_rsvp'
  post 'guests/save-address', :to => 'guests#saveAddress'
  patch 'guests/save-address', :to => 'guests#updateAddress'
  get 'guests/sign_in' => 'guests#sign_in'
  get 'guests/:id/dashboard', :to => 'guests#dashboard', :as  => 'guests_dashboard'


  resources :guest_addresses

  # session control
  post "sessions/new_admin"
  post "sessions/new_guest"
  get "sessions/destroy_admin"
  get "sessions/destroy_guest"

  root "index#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
