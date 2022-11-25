Rails.application.routes.draw do
  devise_for  :users,
              defaults: { format: :json },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                confirmations: 'users/confirmations'
              }
  devise_scope :user do
    post 'users/:id/child_profile', to: 'users/child_profiles#create', as: 'create_child_profile'
    patch 'users/:id/child_profile', to: 'users/child_profiles#update', as: 'update_child_profile'
  end
end
