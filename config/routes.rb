Rails.application.routes.draw do
  root "pages#home"
  get '/update' => "pages#update_video"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # scope :ujs, defaults: { format: :ujs } do
  #   patch 'pages_totalvisits' => 'pages#totalvisits'
  # end
  get '/update_visits_keeps' => "pages#update_visits_keeps"

  get "/login", to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#create"
  resource :session, only: [:create, :destroy]
  get "/logout", to: "sessions#destroy"
  get '/auth/failure', to: redirect('/')
  mount ActionCable.server => '/cable'
  get "/user/subscribe/:channel_id", to: "users#subscribe", as: "subscribe"

  resource :stream, only: [:create, :destroy]
  get "/queue", to: "streams#create"
end
