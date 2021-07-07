App::Application.routes.draw do

  # resources :notes do
  #       member do
  #         get 'list'
  #         post 'insert'
  #         put 'update'
  #         delete 'remove'
  #       end
  #       collection do
  #         get 'list'
  #       end
  # end


  # use resource
  # get "/notes", to: "notes#list"
  # get "/notes/:id", to: "notes#details"
  # post "/notes", to: "notes#insert"
  # put "/notes/:id", to: "notes#update"
  # delete "/notes/:id", to: "notes#remove"

  get "/folders", to: "folders#list"
  get "/folders/:id", to: "folders#details"
  post "/folders", to: "folders#insert"
  put "/folders/:id", to: "folders#update"
  delete "/folders/:id", to: "folders#remove"

  get "/users", to: "users#list"
  get "/users/:id", to: "users#details"
  post "/users", to: "users#insert"
  put "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#remove"

  post 'authenticate', to: 'authentication#authenticate'


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
  #     # (app1/controllers/admin/products_controller.rb)
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
