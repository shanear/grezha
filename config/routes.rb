Daughters::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  get    "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  get    "/logout", to: "sessions#destroy"

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

       resources :relationships, except: [:new, :edit],
          defaults: { format: "json" }

      resources :vehicles, except: [:new, :edit],
          defaults: { format: "json" }

      resources :connections, except: [:new, :edit, :update],
          defaults: { format: "json" }
    end
  end

  root :to => 'offline#app'
end
