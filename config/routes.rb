Rails.application.routes.draw do
  resources :pixels, except: [:new, :edit, :destroy]
  resources :users, except: [:new, :edit, :destroy]
  mount SseRailsEngine::Engine, at: '/sse'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

SseRailsEngine.access_control_allow_origin = "*"

