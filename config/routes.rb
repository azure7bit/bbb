BandungBangkitBersinar::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => :user_registrations}

  resources :users, { path:"user-management" } do
    collection do
      delete :delete_all
    end
    get :export
  end

  resources :suppliers do
    collection do
      delete :delete_all
      get :print_preview
      get :items_info
      get :export
    end
    get :print_orders, :on => :member
  end

  resources :customers do
    collection do
      delete :delete_all
      get :export
    end
  end

  resources :categories do
    collection do
      delete :delete_all
      get :export
    end
  end

  resources :items do
    collection do
      delete :delete_all
      get :critical
      get :export
    end
  end

  resources :purchase_orders, except: [:edit, :update, :destroy] do
    collection do
      get :supplier_info
      get :items_info
      get :export
    end
    get :print_po, :on => :member
  end

  resources :sales_invoices, except: [:edit, :update, :destroy] do
    collection do
      get :customer_info
      get :items_info
      get :export
    end
    get :print_invoice, :on => :member
  end

  resources :companies, only: [:edit, :update]

  resources :receive_orders, except: [:edit, :destroy] do
    get :export, :on => :collection
    get :print_invoice, :on => :member
  end

  get "po_history" => "home#purchase_history", :as => "po_history"
  get "sales_history" => "home#sales_history", :as => "sales_history"
  get "return_po_number/:date" => "purchase_orders#return_number", :as => "return_po_number"
  get "return_so_number/:date" => "sales_invoices#return_number", :as => "return_so_number"
  get "return_receive_number/:date" => "receive_orders#return_number", :as => "return_receive_number"
  
  root :to => 'home#index'

  match '*path', :to => 'pages#routing_error'
end