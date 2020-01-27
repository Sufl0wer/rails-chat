Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root controller: :rooms, action: :index

  resources :room_messages
  resources :rooms
end
