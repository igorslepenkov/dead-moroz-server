Rails.application.routes.draw do
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
    resources :child_reviews, only: [:create]
  end
end
