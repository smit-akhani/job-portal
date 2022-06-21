class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?
  
      register_failed
    end
  
    def register_success
      @user = User.find(current_user.id)
      render json: {
        message: 'Signed up sucessfully.',
        user: @user
      }, status: :ok
    end
  
    def register_failed
      render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
    end
end