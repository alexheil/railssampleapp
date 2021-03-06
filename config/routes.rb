BeatsRealmApp::Application.routes.draw do
  get "artist_bios/edit"
  root "static_pages#home"
  get 'faq' => 'static_pages#faq'
  get 'contact' => 'static_pages#contact'
  get 'privacy_policy' => 'static_pages#privacy_policy'
  get 'terms_of_service' => 'static_pages#terms_of_service'
  get 'copyright_info' => 'static_pages#copyright_info'
  get 'artist_signup' => 'artists#new'
  get 'login' => 'artist_sessions#new'
  delete 'logout' => 'artist_sessions#destroy'
  get 'discover' => 'artists#index'
  resources :artists do
    get 'create_bio'
    get 'edit_bio'
    get 'bio'
  end
  resources :artist_bios, only: [:edit, :update]
  resources :artist_sessions, only: [:new, :create, :destroy]
  resources :artist_account_activations, only: [:edit]
  resources :artist_password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]






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
