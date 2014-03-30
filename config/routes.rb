Sangrah::Application.routes.draw do

  root to: 'home#index'

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
  end

  resources :copies do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
  end

  resources :memberships do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
  end

  resources :members do
    get :copy
    patch :lock, :unlock, :archive, :unarchive
  end

  resources :issues do
    patch :cancel, :close
  end

  resources :reservations do
    patch :cancel, :close
  end

  resources :reports, only: [:index, :show]

end
