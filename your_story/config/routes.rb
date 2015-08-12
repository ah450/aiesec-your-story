Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do 
    resources :participants do 
      resources :stories
    end
  end
end
