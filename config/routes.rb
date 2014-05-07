Daughters::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  get    "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
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

      resources :vehicles, only: [:index, :create, :update, :destroy],
        defaults: { format: "json" }

      resources :connections, only: [:create],
                          defaults: { format: "json" }
    end
  end

  root :to => 'offline#app'
end
