BandungBangkitBersinar::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => :user_registrations}

  resources :mix_items

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
      get :items_info
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

  resources :receive_orders, except: [:edit, :update, :destroy] do
    get :export, :on => :collection
    get :print_invoice, :on => :member
  end

  resources :manage_stocks, :except => [:new, :show, :destroy]

  resources :reports, only: [:index, :create] do
    collection do
      get :preview
    end
  end

  resources :supplier_payments, except: [:edit, :update, :destroy] do
    collection do
      get :preview
    end
  end

  resources :customer_payments, except: [:edit, :update, :destroy] do
    collection do
      get :preview
    end
  end
  resources :rek_accounts, except: [:edit, :update, :destroy] do
    collection do
      get :preview
    end
  end

  
  get "po_history" => "home#purchase_history", :as => "po_history"
  get "sales_history" => "home#sales_history", :as => "sales_history"
  get "file_managers"=>"home#file_managers", :as => "file_managers"
  get "return_po_number/:date" => "purchase_orders#return_number", :as => "return_po_number"
  get "return_so_number/:date" => "sales_invoices#return_number", :as => "return_so_number"
  get "return_receive_number/:date" => "receive_orders#return_number", :as => "return_receive_number"
  get "return_supplier_payment_number/:date" => "supplier_payments#return_number", :as => "return_supplier_payment_number"
  get "return_customer_payment_number/:date" => "customer_payments#return_number", :as => "return_customer_payment_number"
  get "manage_stock/:invoice_number/item/:item_id" => "manage_stocks#new", :as => "manage_item_stock"


  root :to => 'home#index'

  match 'elfinder' => 'home#elfinder'
  match '*path', :to => 'pages#routing_error'
end
