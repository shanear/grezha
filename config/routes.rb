Daughters::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users


  get    "/login", to: "sessions#new"
  get    "/admin/login", to: "sessions#admin_new"
  get    "/admin/logout", to: "sessions#admin_destroy"
  delete "/logout", to: "sessions#destroy"
  get    "/logout", to: "sessions#destroy"

  get    "/reset-password", to: "account#reset_password"
  get    "/reset-password/:token", to: "account#reset_password"
  patch  "/reset-password", to: "account#reset_password"
  get    "/forgot-password", to: "account#forgot_password"
  post   "/forgot-password", to: "account#forgot_password"

  get    "/birthdays", to: "contacts#birthdays"
  get    "/ping", to: "application#ping", defaults: { format: "json" }

  get "/application.manifest", to: "offline#manifest",
    format: :appcache

  namespace :api, defaults: { format: "json" } do
    match "/:x", to: "base#index", via: [:options]
    match "/:x/:y", to: "base#index", via: [:options]
    match "/:x/:y/:z", to: "base#index", via: [:options]

    get "/ping", to: "base#index"
    get "/v2/ping", to: "base#index"
    get "/csrf", to: 'csrf#index'

    namespace :v1 do
      resources :contacts, except: [:new, :edit] do
        post 'upload_image', on: :member
      end

      resources :people, except: [:new, :edit]
      resources :relationships, except: [:new, :edit]
      resources :users, except: [:new, :edit, :update]
      resources :vehicles, except: [:new, :edit]
      resources :connections, except: [:new, :edit, :update]
    end

    namespace :v2 do
      post "/authenticate", to: "sessions#create"
      post "/invalidate", to: "sessions#destroy"
      post "/forgot-password", to: "account#forgot_password"
      post "/reset-password", to: "account#reset_password"

      resources :connections, except: [:new, :edit, :update]
      resources :contacts, except: [:new, :edit]
      resources :users, except: [:new, :edit, :update]
      resources :people, except: [:new, :edit]
      resources :relationships, except: [:new, :edit]
      resources :participations, except: [:new, :edit, :show]
      resources :vehicles, except: [:new, :edit]
      resources :events, except: [:new, :edit]
      resources :programs, except: [:new, :edit]
    end
  end

  root :to => 'offline#app'
end
