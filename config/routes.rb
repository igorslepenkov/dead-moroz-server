Rails.application.routes.draw do
  devise_for  :users,
              defaults: { format: :json },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                confirmations: 'users/confirmations'
              }
  devise_scope :user do
    post 'users/:id/child_profile', to: 'users/registrations#create_child_profile', as: 'create_child_profile'
    put 'users/:id/child_profile', to: 'users/registrations#update_child_profile', as: 'update_child_profile'
  end
end
