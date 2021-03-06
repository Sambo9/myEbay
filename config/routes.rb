Rails.application.routes.draw do

  resources :bids
  match "/products/add_new_bid" => "products#add_new_bid", :as => "add_new_bid_to_products", :via => [:post]
   match "/products/add_new_comment" => "products#add_new_comment", :as => "add_new_comment_to_products", :via => [:post]
   match "/users/add_new_comment" => "users#add_new_comment", :as => "add_new_comment_to_users", :via => [:post]
   post '/rate' => 'rater#create', :as => 'rate'

   resources :categories do
      get :autocomplete_category_name, on: :collection
   end
   resources :products do
      resources :comments
   end

   get 'categories/list/:name' => 'categories#list', as: 'category_list'

   get 'home/index'
   # get 'register' => 'devise/registrations/edit#register'

   # devise_for :users
   devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations'}
   resources :users, :only => [:show, :index, :update, :destroy, :edit]

   # The priority is based upon order of creation: first created -> highest priority.
   # See how all your routes lay out with "rake routes".

   # You can have the root of your site routed with "root"
   # root 'welcome#index'
   root to: "home#index"

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
