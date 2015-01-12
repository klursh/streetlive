Streetlive::Application.routes.draw do

  root "root#top"

  get "/login" => "root#login"
  
  namespace :my do
    get :top
    get :info
    get :artist
    get :scout
    get :movies
  end

  namespace :youtube do
    get :uploads
  end

  get "users/logout"
  resources :users, except: [:index]
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :artists, except: [:index], shallow: true do
    resources :messages, only: [:index, :new, :create]
    resources :movies
  end

  resources :scouts, except: [:index]

  namespace :artists do
    namespace :rankings do
      get :view
      get :message
    end
  end
  namespace :movies do
    namespace :rankings do
      get :view
    end
  end

  # TODO: どうにかする
  # Googleで初めてOAuth認証した後、登録せずに、そのセッションを残したままもう一度OAuth認証したときに発生するエラーの仮回避策。
  # see: http://stackoverflow.com/questions/11004442/devise-omniauth-undefined-method-new-session-path
  get 'users/new', :as => :new_session

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
