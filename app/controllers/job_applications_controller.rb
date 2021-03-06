class JobApplicationsController < ApplicationController
    before_action :authenticate_user! ,except: [:show,:update, :all_applications,:show_user_profile ]
    before_action :authenticate_company! ,only: [:all_applications,:show_user_profile]
    before_action :set_user ,except: [:show,:update, :all_applications,:show_user_profile ]

    def all_applications
        @company = Token.new.get_company_from_token(request)
        if @company
            @job_applications = JobApplication.where(job_id: Job.where(company_id: @company.id).pluck(:id))
            render json: @job_applications, status: 200
        end
    end
    def show_user_profile 
        @job_applications = JobApplication.where(job_id: Job.where(company_id: current_company.id).pluck(:id))
        @user_applications = JobApplication.where(user_id: params[:id])
        if(@user_applications==nil||@job_applications==nil)
            render json: {
                message: "User is not applied for any job in your comapny"
            }, status: 400
            return
        end
        temp=@job_applications&@user_applications
        p temp,"----------------------"
        if(temp.size()==0)
            render json: {
                message: "User is not applied for any job in your comapny"
            }, status: 400
        else
            user=User.find_by(id:params[:id])
            render json: user, status: 200
        end 
    end
    def create
        if check_user_detail
            p @user
            @job_application = @user.job_applications.new(job_application_params)
            if @job_application.save
                JobMailer.with(job_application:@job_application).job_applyed.deliver_now
                render json: {
                    message: "Applied successfully"
                }, status: 200
            else 
                render json: {
                    message: @job_application.errors.full_messages
                }, status: 400
            end
        else
            render json: {
                message: "Please complete your profile before applying"
            }, status: 400
        end
    end
    def my_job_application
        @job_applications = current_user&.job_applications
        render json: @job_applications, status: 200
    end
    def delete_job_application
        @job_applications = current_user&.job_applications.find_by(id: params[:id])

        if(@job_applications==nil)
            render json: { message: "Job application not found" }, status: 404
        else
            if(@job_applications[:status]=="Application Received")
                @job_applications.destroy
                render json: { message: "Job application deleted" }, status: 200
            else
                render json: { message: "You can't delete this job application" }, status: 400
            end
        end
        
    end
    
    def show
        @job_application = Job.find(params[:id])
        if (@job_application.job_applications.nil? || @job_application.job_applications.empty?)
            render json: {
                message: "currently no applicants"
            }, status: 400
        elsif ((@job_application.user_id!=nil&&@job_application.user_id == current_user&.id)||@job_application.company_id == current_company&.id)
            @job_application = @job_application.job_applications
            render json: @job_application, status: 200
        else
            render json: {
                message: "You are not authorized to view this job application"
            }, status: 400
        end
    end
    def update
        @job_application = JobApplication.find_by(id: params[:id])
        if (@job_application.job.job_applications.nil? || @job_application.job.job_applications.empty?)
            render json: {
                message: "currently no applicants"
            }, status: 400
        elsif ((@job_application.job.user_id!=nil&&@job_application.job.user_id == current_user&.id)||@job_application.job.company_id == current_company&.id)
            if @job_application.update(job_application_params)
                JobMailer.with(job_application:@job_application).job_status_change.deliver_now
                render json: {
                    message: "Application updated successfully"
                }, status: 200
            else
                render json: {
                    message: @job_application.errors.full_messages
                }, status: 400
            end
            
        else
            render json: {
                message: "You are not authorized to view this job application"
            }, status: 400
        end
    end
    def my_created_job_application
        @job_applications = current_user&.job_applications
        render json: @job_applications, status: 200
    end
    private

    def job_application_params
        params.require(:job_application).permit(:job_id, :user_cv_id ,:resume, :status, :apply_date, :feedback)
    end

    def set_user
        @user = Token.new.get_user_from_token(request)
    end
   
    def check_user_detail
        p @user.user_detail.valid?
        return @user.user_detail.valid?
    end
end
