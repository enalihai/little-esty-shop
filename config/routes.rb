Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :merchants do
    get '/:id/items', to: 'items#index'
    get '/:id/items/new', to: 'items#new'
    post '/:id/items', to: 'items#create'
    get '/:id/items/:id', to: 'items#show'
    get '/:id/items/:id/edit', to: 'items#edit'
    patch '/:id/items/:id', to: 'items#update'
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index]
  end
end
