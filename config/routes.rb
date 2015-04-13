Pru1::Application.routes.draw do
  resources :nominas do
    collection do
      get :new_massive
      post :create_for_all_therapists
    end
  end

  resources :cancellations

  resources :fixed_therapies do
    put :update_massive_time_ranges, :on => :collection
  end

  resources :services do
    collection do
      #get :ajax_calculate_to_fecha_hora
      get :ajax_therapist_timetable
      get :ajax_get_costo_terapia
      get :today_sessions
    end


  end

  resources :payments

  resources :presences do
    get :today_sessions, :on => :collection
  end

  resources :therapists do
    get :ajax_get_available_hours, :on => :collection
    put :update_massive_time_ranges, :on => :collection
  end

  resources :patients

  #get "dashboards/index", :to => "dashboards#index", :as => "dashboards"

  devise_for :users

  resources :users do
    match 'resend_password_instructions', :on => :collection
  end

  get "application/access_denied"

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
  root :to => "application#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  match '*path' => "application#action_controller_error"
end
