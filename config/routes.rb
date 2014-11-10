Daughters::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  get    "/login", to: "sessions#new"
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

  namespace :api do
    namespace :v1 do
      resources :contacts, except: [:new, :edit],
          defaults: { format: "json" } do
        post 'upload_image', on: :member
      end

       resources :people, except: [:new, :edit],
          defaults: { format: "json" }

       resources :relationships, except: [:new, :edit],
          defaults: { format: "json" }

      resources :users, except: [:new, :edit, :update],
        defaults: {format: "json"}

      resources :vehicles, except: [:new, :edit],
          defaults: { format: "json" }

      resources :connections, except: [:new, :edit, :update],
          defaults: { format: "json" }
    end
  end

  root :to => 'offline#app'
end
