Rails.application.routes.draw do

  devise_for :users
  resources :orders
  resources :products
  resources :order_items

  root 'products#index'

  get 'flower_bunch/application'
  post 'flower_bunch/create'

  post 'order_item/new'
  get 'order_item/index'
  get 'order_item/create'
  get 'order_item/show'
  get 'order_item/destroy'

  get 'cart/show'
  get 'cart/payment'
  get 'cart/thanks'
  get 'user/registration_new'
  get 'user/data_edit'
  get 'user/list_of_users'
  post 'user/new'
  post 'user/delete'
  get 'user/admin_panel'
  get 'user/user_panel'
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
