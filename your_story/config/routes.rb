Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do 
    resources :participants do 
      resources :stories, only: [:index, :create, :show]
      resources :avatar, only: [:create, :show]
    end
    resources :states, only: [:index, :show]
    resources :local_chapters, only: [:index, :show]
    resources :configurations, only: [:index]
    resources :tokens, only: [:create]
  end
end
