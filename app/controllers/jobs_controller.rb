class JobsController < ApplicationController
    before_action :check_accessability, only: [:create]
    before_action :set_job, only: [:update,:destroy]
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
            add_skill(@job)
            render :json =>{status:"success",data: @job} , status: 200
        else 
              render :json =>{status:@job.errors.full_messages} , status: 400
        end
    end
    def update
        
        update_status=@job.update(job_params)
        p update_status
        if(update_status)
            add_skill(@job)
            
            render :json =>{message:"success",data: @job} , status: 200
        else 
              render :json =>{message:update_status} , status: 400
        end
    end

    def destroy
        if(@job.destroy)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@job.destroy!} , status: 400
        end

    end
    private
    def add_skill(job)
        skill_arr=params[:skill]
        job.skill.clear
        job.skill<<(Skill.where(id:skill_arr))
        job.save
    end
    def check_accessability
        @ability=JobManager.where(user:current_user,company_id:params[:job][:company_id]).first
    
        if(@ability!=nil)
            return true
        end
        if(current_user!=nil||(current_user==nil&&current_company==nil))
            render :json =>{message:"You are not Authorize to do this"} , status: 400
            return 
        end
        if(current_company!=nil)
            params[:job][:company_id]=current_company.id
        end

    end
    def set_job
        p current_company
        if(current_company==nil&&current_user==nil)
            render :json =>{message:"You are not Authorize to do this"} , status: 400
            return
        end
        @ability=JobManager.where(user:current_user,company_id:params[:job][:company_id]).first
        
        @job=Job.find_by(id: params[:id])
        if((current_user!=nil&&@job.user_id!=current_user.id)||(current_company!=nil&&@job.company_id!=current_company.id))
            render :json =>{message:"You are not Authorize to do this"} , status: 400
            return
        end

        if(@ability!=nil)
            return true
        end
        if(current_company!=nil)
            params[:job][:company_id]=current_company.id
        end

    end
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
    
end
