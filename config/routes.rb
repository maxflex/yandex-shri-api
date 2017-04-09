Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :schools, only: [:index]
    resources :lectures, only: [:index, :show]
    resources :speakers, only: [:show]
  end
end
