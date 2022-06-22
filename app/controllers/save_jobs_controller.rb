class SaveJobsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @save_job=SaveJob.where(user_id: current_user.id)
        render json: {
            message: "Save Job List",
            data: @save_job
            } , status: 200
    end
    def add_or_remove_save_job
        
        @save_job=SaveJob.where(user_id: current_user.id,job_id: params[:id]).first
        if(@save_job==nil)
            @save_job=SaveJob.new(user_id: current_user.id,job_id: params[:id])
            if(@save_job.save)
                render :json =>{status:"Job is Added in Save"} , status: 200
            else 
                  render :json =>{status:@save_job.save!} , status: 400
            end
        else
            p "Delete"
            if(@save_job.destroy)
                render :json =>{status:"Job is removed From Save"} , status: 200
            else
                  render :json =>{status:@save_job.destroy!} , status: 400
            end
        end
        
    end
    
    private
    def set_user_detail
        @curent_user=Token.new.get_user_from_token(request)
        if(@curent_user!=current_user)
            render :json =>{message:"Something went wrong"} , status: 400
            return
        end
    end
end
