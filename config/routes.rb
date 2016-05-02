Sensus::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'maprao' => 'maprao#index'

  get 'help' => 'home#help'
  get 'data' => 'data#index'
  get 'training' => 'training#index'
  get 'results' => 'results#index'

  # get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
  resources :answers, only: [:show] do
    post 'classify'
    post 'declassify'
  end

  resources :students
  resources :survey_models
  resources :surveys do
    get 'training'
    get 'results'
    get 'filters'
    post 'upload_filters'
    post 'upload_close_ended_answers'
    resources :questions do
      get 'charts'
      get 'unigrams'
      get 'bigrams'
      get 'trigrams'
      get 'download_answers'
      get 'download_classifications'
      get 'answers'
      post 'upload_stems'
      post 'upload_classifications'
      post 'upload_sentiments'
    end
  end

  resources :questions do
    get 'answers'
    get 'categories'
    get 'download_answers'
    get 'download_classifications'
    get 'unigrams'
    get 'bigrams'
    get 'trigrams'
    get 'charts'
    post 'upload_stems'
    post 'upload_classifications'
    post 'upload_sentiments'
  end

  mount Resque::Server, :at => "/resque"

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
