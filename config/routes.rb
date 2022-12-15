require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for  :users,
              defaults: { format: :json },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                confirmations: 'users/confirmations'
              }
  resources :users do
    resource :child_profile, only: %i[show create update]
  end

  resources :child_profiles, only: %i[index] do
    resources :child_presents, only: %i[create destroy]
    resources :child_reviews, only: %i[create destroy]
    resource :translation, only: %i[show]
  end
end
