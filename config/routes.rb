Rails.application.routes.draw do
  devise_for :admins, path: 'admin', skip: :registrations
  devise_scope :admin do
    authenticated do
      root to: 'admin/room_service/orders#index', as: :authenticated_admin_root
    end

    unauthenticated do
      root to: redirect('admin/sign_in'), as: :unauthenticated_admin_root
    end
  end

  namespace :admin do
    resources :reservations, except: [:show, :destroy]
    resource :reservation_import, only: [:new, :create]

    namespace :room_service do
      resources :orders, only: [:index, :show] do
        member do
          put :complete
        end
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v0 do
      resources :users, only: [:create, :show] do
        namespace :room_service do
          resources :orders, only: [:index, :create]
        end
      end
      resource :authentication, only: [:create, :destroy]
      resources :reservation_associations, only: [:create]

      namespace :room_service do
        resources :categories, only: [:index] do
          resources :sub_categories, only: [:index]
        end

        resources :items, only: [:show]
      end
    end
  end
end
