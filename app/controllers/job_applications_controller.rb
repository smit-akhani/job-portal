class JobApplicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def create
        if check_user_detail
            @job_application = @user.build_job_application(job_application_params)
            if @job_application.save
                render json: {
                    message: "Applied successfully"
                }, status: 200
            else 
                render json: {
                    message: "Something went wrong"
                }, status: 400
            end
        else
            render json: {
                message: "Please complete your profile before applying"
            }, status: 400
        end
    end

    def show

    end

    def destroy

    end

    private

    def job_application_params
        params.require(:job_application).permit(:job_id, :user_cv_id ,:resume, :status, :apply_date, :feedback)
    end

    def set_user
        @user = Token.new.get_user_from_token(request)
    end

    def check_user_detail
        if @user.user_detail.nil? || @user.user_detail.empty?
            return false
        else
            return true
        end
    end
end
