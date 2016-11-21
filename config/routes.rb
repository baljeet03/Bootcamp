Project::Application.routes.draw do

  match '/new' => 'tasks#new'
  match 'tasks/:id/edit' => 'tasks#edit', :as => :task, :via => :get
  match 'tasks/:id/edit' => 'tasks#update', :as=> :edit_task, :via => :put
  resource :tasks do
    match 'filter/:status' => 'tasks#filter', :as => :filter_on_status, :via => [:get]
    match 'changeStatus/:id' => 'tasks#changeStatus', :as => :change_status, :via => [:get, :put]
    match 'sortByPriority/:status/:ordering' => 'tasks#sortPriority', :as => :sort_by_priority
    match 'sortByDeadline/:status/:ordering' => 'tasks#sortDeadline', :as => :sort_by_deadline
    match 'exportTask' => 'tasks#exportTask', :as => :export
  end
  resource :tasks
  root :to => "tasks#index"
  match 'tasks/:id' => 'tasks#show', :as => :show


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
