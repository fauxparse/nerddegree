Rails.application.routes.draw do
  resources :episodes
  root to: 'episodes#index'
end
