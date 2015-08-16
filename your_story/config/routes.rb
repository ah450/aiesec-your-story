Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do 
    resources :participants do 
      resources :stories, only: [:index, :create, :get]
      resources :avatar, only: [:create, :get]
    end
    resources :states, only: [:index, :show]
    resources :local_chapters, only: [:index, :get]
    resources :configurations, only: [:index]
    resources :tokens, only: [:create]
  end
end
