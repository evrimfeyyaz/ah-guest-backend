Rails.application.routes.draw do
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
