Rails.application.routes.draw do
  namespace :v0 do
    namespace :room_service do
      get 'categories/index'
    end
  end

  namespace :room_service do
    get 'categories/index'
  end

  namespace :v0, defaults: { format: :json } do
    namespace :room_service, path: 'room-service' do
      resources :categories, only: [:index]
    end
  end
end
