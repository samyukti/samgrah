Sangrah::Application.routes.draw do

  unauthenticated do
    root to: 'home#index', as: :public_root
    get '/about', to: 'home#about'
    get '/policies', to: 'home#policies'
    get '/items', to: 'home#items'
  end

  authenticated :user do
    root to: 'dashboard#index', as: :application_root
  end

  match 'welcome', to: 'dashboard#welcome', via: [:get]

  devise_for :users, skip: [:registrations]
  as :user do
    get 'my/profile/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'my/profile' => 'devise/registrations#update', as: 'user_registration'
  end

  resources :users do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
  end

  resources :categories do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
  end

  resources :creators do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
  end

  resources :items do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
    collection do
      match 'table', to: 'items#table', via: [:get]
      match 'select', to: 'items#select', via: [:get]
    end
  end

  resources :copies do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
    collection do
      match 'select', to: 'copies#select', via: [:get]
    end
  end

  resources :memberships do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
    collection do
      match 'table', to: 'memberships#table', via: [:get]
    end
  end

  resources :members do
    get :copy
    get 'photo(/:version)', to: 'members#photo'
    patch :lock, :unlock, :archive, :unarchive
    collection do
      match 'table', to: 'members#table', via: [:get]
      match 'select', to: 'members#select', via: [:get]
    end
  end

  resources :issues do
    patch :cancel, :close
  end

  resources :reservations do
    patch :cancel, :close
  end

  resources :receipts do
    patch :cancel, :approve
  end

  match 'search', to: 'search#results', via: [:get]

  resources :reports, only: [:index] do
    collection do
      match 'show/:report_name', to: 'reports#show', via: [:get, :post], as: 'show'
    end
  end

  resources :settings
end
