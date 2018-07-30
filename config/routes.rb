Rails.application.routes.draw do
  resources :pixels, except: [:new, :edit, :destroy]
  resources :users, except: [:new, :edit, :destroy]
  get '/subscribe', to: 'pixels#subscribe'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
