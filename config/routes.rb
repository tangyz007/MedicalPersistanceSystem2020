Rails.application.routes.draw do
  
  get 'provider/index'

  get 'patient/index'

  get 'home/index'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :skip => [:registrations] 
  resources :questions
  resources :request
  # resources :signup
  #get '/' => 'questions#login'
  get '/dashboard' => 'questions#dashboard'
  get '/unsuccess' => 'home#unsuccess'
  # get '/logining'=> 'questions#login'
  match "request/user" => "request#create", via: [:post]
  match "admin/request" => "admin#request", via: [:post]
  get '/success' => 'request#success'
  get '/provider/feedback' => 'provider#edit_feedback', :as => "edit_provider_feedback"
  post '/provider/feedback' => 'provider#update_feedback', :as => "update_provider_feedback"
  # get '/success'=> 'provider#success'
  # post '/signup'=> 'provider#signup'
  
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
  #root 'questions#login'
  get '/login' => 'home#index', :as => :login
  root 'main#index'
  get '/users/sign_out/' =>'sessions#destroy', :as => :logout
  #logout 'sessions#destroy'
  #root to: "controller#action"
  #root questions_path
end
