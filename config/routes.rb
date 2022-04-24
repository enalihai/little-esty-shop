Rails.application.routes.draw do

  get '/', to: 'welcome#index'

  resources :merchants do
    get '/items', to: 'merchant_items#index'
    post '/items', to: 'merchant_items#create'
    get '/items/new', to: 'merchant_items#new'
    get '/items/:item_id/edit', to: 'merchant_items#edit'
    get '/items/:item_id', to: 'merchant_items#show'
    patch '/items/:item_id', to: 'merchant_items#update'

    get '/invoices', to: 'merchant_invoices#index'
    post '/invoices', to: 'merchant_invoices#create'
    get '/invoices/new', to: 'merchant_invoices#new'
    get '/invoices/:invoice_id/edit', to: 'merchant_invoices#edit'
    get '/invoices/:invoice_id', to: 'merchant_invoices#show'
    patch '/invoices/:invoice_id', to: 'merchant_invoices#update'

    get '/invoice_items', to: 'merchant_invoice_items#index'
    post '/invoice_items', to: 'merchant_invoice_items#create'
    get '/invoice_items/new', to: 'merchant_invoice_items#new'
    get '/invoice_items/:invoice_item_id/edit', to: 'merchant_invoice_items#edit'
    get '/invoice_items/:invoice_item_id', to: 'merchant_invoice_items#show'
    patch '/invoice_items/:invoice_item_id', to: 'merchant_invoice_items#update'
  end

  get '/merchants/:id/dashboard', to: 'merchants#show'
  get '/merchants/:id/bulk_discounts', to: 'merchant_bulk_discounts#index'
  delete '/merchants/:id/bulk_discounts', to: 'merchant_bulk_discounts#destroy'
  get '/merchants/:id/bulk_discounts/new', to: 'merchant_bulk_discounts#new'
  post '/merchants/:id/bulk_discounts', to: 'merchant_bulk_discounts#create'
  get '/merchants/:id/bulk_discounts/:bulk_discounts_id', to: 'merchant_bulk_discounts#show'
  get '/merchants/:id/bulk_discounts/:bulk_discounts_id/edit', to: 'merchant_bulk_discounts#edit'
  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
    resources :invoices, only: [:index, :show, :update]
  end
end
