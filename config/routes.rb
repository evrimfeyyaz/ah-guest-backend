Rails.application.routes.draw do
  namespace :v0, defaults: { format: :json } do
    namespace :room_service, path: 'room-service' do
      resources :categories, only: [:index, :show] do
        resources :sections, only: [:index]
      end
    end
  end
end
