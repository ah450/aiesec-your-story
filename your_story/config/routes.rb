Rails.application.routes.draw do
  namespace :api do
    resources :participants, only: [:index, :create, :show, :destroy] do
      resources :stories, only: [:index, :create, :show, :update]
      resources :avatars, only: [:create, :show, :index]
    end
    resources :states, only: [:index, :show]
    resources :local_chapters, only: [:index, :show]
    resources :configurations, only: [:index]
    resources :tokens, only: [:create]
    resources :profile_types, only: [:index]
    resources :member_profile_types, only: [:index]
  end
end
