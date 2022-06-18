class JobsController < ApplicationController
    
    def index
        @jobs=Job.all
        render json: {
            message: "Jobs List",
            data: @jobs
            } , status: 200
    end
    def show
        @job=Job.find_by(id: params[:id])
        
        render json: {
            message: "Show Successfully",
            data: @job
            } , status: 200
    end

    def create
        @job=Job.new(job_params)
        @job.user=current_user
        if(@job.save)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@job.save!} , status: 400
        end
    end
    def update
        @job=Job.find_by(id: params[:id])
        update_status=@job.update(job_params)
        if(update_status)
            render :json =>{message:"success"} , status: 200
        else 
              render :json =>{message:update_status} , status: 400
        end
    end

    def destroy
        @job=Job.find_by(id: params[:id])
        if(@job.destroy)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@experience.destroy!} , status: 400
        end

    end
    private
    def set_user_detail
        @curent_user=Token.new.get_user_from_token(request)
        if(@curent_user==nil)
            render :json =>{message:"User is not logged in"} , status: 400
            return
        end
    end
    def job_params
        params.require(:job).permit(
            :job_title,:job_description,
            :job_application_link,:easy_apply,
            :last_date_to_apply,:location,
            :year_of_exp,:company_id)
    end
    def set_job
        if(!@curent_user.has_role?"admin")
            @experience=Experience.where(id: params[:id],user_id: @curent_user.id).first
        else
            @experience=Experience.find_by(id: params[:id])
        end
    end

end
