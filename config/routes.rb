Rails.application.routes.draw do
  resources :boards, except: [:new, :edit]
  resources :pixels, except: [:new, :edit]
  resources :users, except: [:new, :edit, :destroy]
  get '/subscribe', to: 'pixels#subscribe'
  get '/boards/:id/reset', to: 'boards#reset'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
