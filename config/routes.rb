Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v0 do
      resources :users, only: [:create]

      namespace :room_service, path: 'room-service' do
        resources :categories, only: [:index, :show] do
          resources :sections, only: [:index]
        end

        resources :items, only: [:show]
      end
    end
  end
end
