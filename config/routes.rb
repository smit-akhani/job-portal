Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :companies,
              controllers: {
                sessions: 'companies/sessions',
                registrations: 'companies/registrations',
                confirmations: 'companies/confirmations'
              }
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               confirmations: 'users/confirmations'
             }

  get '/member-data', to: 'members#show'
  get '/company-data', to: 'companies#show'

    resources :user_details do 
      collection do
        post :resend_confirmation
      end
    end
    resources :skills
    resources :job_alerts
    resources :jobs do 
      collection do
        get :search
      end
    end
    resources :save_jobs do 
      collection do 
        post "/add_or_remove_save_job/:id"=>"save_jobs#add_or_remove_save_job"
      end
    end
   resources :job_manager
    resources :educations do 
      collection do 
        get "/get_user_education/:id" => "educations#get_user_education"
      end
    end
    resources :experiences do 
      collection do 
        get "/get_user_experience/:id" => "experiences#get_user_experience"
      end
    end
    resources :user_cvs do
    end
    resources :user_cv do 
      collection do 
        patch "add_cv"
        get "show_all_cv"
      end
    end
   
  scope :company do
    resource :company_details  do 
      collection do
        post :resend_confirmation
      end
    end
  end

  scope :user do
    resources :job_applications do 
      collection do 
        get "/my_job_application" => "job_applications#my_job_application"
        delete "/delete_job_application/:id" => "job_applications#delete_job_application"
        get "/my_created_job_application"=>"job_applications#my_created_job_application"
      end
    end
  end

  scope :company do
    get "/all_applications" => "job_applications#all_applications"
  end

  resources :companies
end
