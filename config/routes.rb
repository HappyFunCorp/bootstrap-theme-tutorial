Rails.application.routes.draw do
  namespace :admin do
    # get "/stats" => "stats#stats"
    devise_scope :admin_user do
      get '/stats/:scope' => "stats#stats", as: :admin_stats
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :crushes, path: 'crush', param: :slug
  # resources :instagram_likes
  # resources :instagram_comments
  # resources :instagram_posts, path: "feed"
  resources :instagram_users, param: :username, path: 'user'

  get 'feed' => "instagram_posts#index", as: :instagram_posts
  get 'top_stats' => "instagram_posts#stats", as: :instagram_posts_stats

  get 'stats/:username' => "instagram_posts#for_user", as: :posts_for_user

  get 'crushingit' => "crushes#loading", as: :loading_crush

  # Routes for mocking
  # get 'welcome/landing'
  # get 'welcome/loading_crush', as: :load_crush
  # post 'welcome/loading_crush'
  # # get 'welcome/show_crush', as: :show_crush
  # # get 'welcome/show_feed', as: :show_feed
  # get 'welcome/friends', as: :friends
  # get 'welcome/frenemies', as: :frenemies
  # get 'welcome/fans', as: :fans
  # get 'welcome/stars', as: :stars

  # tmp
  # get 'welcome/loading_crush', as: :link_instagram

  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  root 'welcome#landing'
  get '/setup' => 'setup#index'
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
