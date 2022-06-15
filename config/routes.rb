Rails.application.routes.draw do
  devise_for :companies,
              controllers: {
                sessions: 'companies/sessions',
                registrations: 'companies/registrations'
              }
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  get '/company-data', to: 'companies#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
