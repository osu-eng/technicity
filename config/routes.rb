Technicity::Application.routes.draw do



  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}


  resources :region_set_memberships


  resources :region_sets

  get "home", to: 'static_pages#home'
  get "help", to: 'static_pages#help'
  get "about", to: 'static_pages#about'
  get "denied", to: 'static_pages#denied'
  get "notify", to: 'notifications#new'
  get "policies", to: 'static_pages#policies'

  resources :comparisons do
    member do
      post 'new'
    end
  end

  resources :locations


  resources :regions


  resources :studies do
    get :vote,           :on => :member
    get :curate,         :on => :member
    get :results,        :on => :member
    get :region_results, :on => :member
    get :heatmap,        :on => :member
    get :download,       :on => :member
    get :status,         :on => :member
    put :open,           :on => :member
    put :close,          :on => :member
  end

  resources :users

  resources :notifications

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match 'about' => 'static_pages#about'
  match 'help' => 'static_pages#help'
  match 'home' => 'static_pages#home'
  match 'studies' => 'studies#show'
  match 'studies/:id/analyze' => 'studies#summary'
  match 'studies/mine/:user_id' => 'studies#mine'

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
   root :to => 'static_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
