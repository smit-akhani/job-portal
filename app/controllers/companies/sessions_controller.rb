class Companies::SessionsController < Devise::SessionsController
    respond_to :json
  
    private
  
    def respond_with(_resource, _opts = {})
      render json: {
        message: 'You are logged in(company).',
        company: current_company
      }, status: :ok
    end
  
    def respond_to_on_destroy
      log_out_success && return if current_company
  
      log_out_failure
    end
  
    def log_out_success
      render json: { message: 'You are logged out.(company)' }, status: :ok
    end
  
    def log_out_failure
      render json: { message: 'Hmm nothing happened.(company)' }, status: :unauthorized
    end
end