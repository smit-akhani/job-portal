class ExperiencesController < ApplicationController
    before_action :authenticate_user!,except: [:get_user_experience]
    before_action :set_user_detail ,except: [:get_user_experience]
    before_action :set_experience, only: [:show, :update, :destroy]
    def get_user_experience
        @experiences=Experience.where(user_id: params[:id])
        render json: {
            message: "Educations List",
            data: @experiences
            } , status: 200
    end
    
    def show
        render json: {
            message: "Show Successfully",
            data: @experience
            } , status: 200
    end

    def create
        @experience=Experience.new(experience_params)
        @experience.user_id=@curent_user.id
        if(@experience.save)
            add_skill(@experience)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@experience.errors.full_messages} , status: 400
        end
    end
    def update
        
        update_status=@experience.update(experience_params)
        
        if(update_status)
            add_skill(update_status)
            render :json =>{message:"success"} , status: 200
        else 
              render :json =>{message:update_status} , status: 400
        end
    end
    def destroy
       
        if(@experience.destroy)
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
    def experience_params
        params.require(:experience).permit(:title,:employment_type,:company_name,:location,:start_date,:end_date,:current,:description)
    end
    def set_experience
        if(!@curent_user.has_role?"admin")
            @experience=Experience.where(id: params[:id],user_id: @curent_user.id).first
        else
            @experience=Experience.find_by(id: params[:id])
        end
        
    end
    def add_skill(experience)
        skil_arr=params[:skill]
        experience.skill.clear
        experience.skill<<(Skill.where(id:skil_arr))
        experience.save
    end

end
