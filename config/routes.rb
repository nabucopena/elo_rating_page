Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  root "scores#ranking"
  post 'new_game', to: 'games#new'
  post 'new_player', to: 'players#new'
end
