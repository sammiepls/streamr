Rails.application.routes.draw do
  root "pages#home"
  get '/update' => "pages#update_video"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/login", to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#create"
  resource :session, only: [:create, :destroy]
  get "/logout", to: "sessions#destroy"
  get '/auth/failure', to: redirect('/')
end
