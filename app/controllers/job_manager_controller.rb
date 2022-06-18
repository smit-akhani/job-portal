class JobManagerController < ApplicationController
    before_action :authenticate_company!
    # before_action :set_comapny_detail
    
    def index
        @job_managers=JobManager.where(company_id: current_company.id)
        render json: {
            message: "Job Manager List",
            data: @job_managers
            } , status: 200
    end
    def create
        @job_manager=JobManager.new(company_id: current_company.id,user_id: params[:user_id])
        if(@job_manager.save)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@job_manager.save!} , status: 400
        end
    end
    def destroy
        @job_manager=JobManager.where(company_id: current_company.id,user_id: params[:id]).first
        if(@job_manager==nil)
            render :json =>{message:"User is not a job manager"} , status: 400
            return
        end
        p @job_manager
        if(@job_manager.destroy)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@job_manager.destroy!} , status: 400
        end
    end
    
    private
    def set_comapny_detail
        @curent_company=Token.new.get_company_from_token(request)
        p @curent_company
        p current_company
        if(@curent_company!=current_company)
            render :json =>{message:"Something went wrong"} , status: 400
            return
        end
    end
end
