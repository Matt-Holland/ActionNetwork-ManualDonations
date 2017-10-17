Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :campaigns
  resources :donors
  resources :donations

  resources :donors do
    collection do
      post 'search'
      get 'search'
    end
  end

  resources :campaigns do
    collection do
      post 'search'
      get 'search'
    end
  end

end
