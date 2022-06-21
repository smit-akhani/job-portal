class JobApplicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def create
        if check_user_detail
            p @user
            @job_application = @user.job_applications.new(job_application_params)
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
        @job_application = Job.find(params[:id]).job_applications
        render json: @job_application
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
        return @user.user_detail.valid?
    end
end
