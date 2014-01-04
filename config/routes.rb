BandungBangkitBersinar::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => :user_registrations}

  resources :users, { path:"user-management" } do
    collection do
      delete :delete_all
    end
  end

  resources :suppliers do
    collection do
      delete :delete_all
      get :print_preview
      get :items_info
    end
    get :print_orders, :on => :member
  end

  resources :customers do
    collection do
      delete :delete_all
    end
  end

  resources :categories do
    collection do
      delete :delete_all
    end
  end

  resources :items do
    collection do
      delete :delete_all
      get :critical
    end
  end

  resources :purchase_orders do
    collection do
      get :supplier_info
      get :items_info
    end
    get :print_po, :on => :member
  end

  resources :sales_invoices do
    collection do
      get :customer_info
      get :items_info
    end
  end
  
  root :to => 'home#index'

  match '*path', :to => 'pages#routing_error'
end