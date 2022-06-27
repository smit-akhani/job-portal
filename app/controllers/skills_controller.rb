class SkillsController < ApplicationController
    before_action :authenticate_user!,except: [:index,:show]
    before_action :set_user_detail ,except: [:index,:show]
    
    before_action :admin_verify, only: [:create, :update, :destroy]
    # get All skill 
    # get skills
    def index
        @skills=Skill.all
        render json: {
            message: "skill List",
            data: @skills
            } , status: 200
    end
  
    def show
        @skill=Skill.find_by(id: params[:id])
        render json: {
            message: "Skill Successfully",
            data: @skill
            } , status: 200
    end
    def create
        @skill=Skill.new(skill_params)
        if(@skill.save)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@skill.save!} , status: 400
        end
    end
    def update
        skill_obj=Skill.find_by(id: params[:id])
        if(skill_obj==nil)
            render :json =>{message:"Id is invlid"} , status: 400
            return
        end
        update_status=skill_obj.update(skill_params)
        
        if(update_status)
            render :json =>{message:"success"} , status: 200
        else 
              render :json =>{message:update_status} , status: 400
        end
    end
    def destroy
        skill_obj=Skill.find_by(id: params[:id])
        if(skill_obj==nil)
            render :json =>{message:"Id is invlid"} , status: 400
            return
        end
        if(skill_obj.destroy)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:skill_obj.destroy!} , status: 400
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
    def skill_params
        params.require(:skill).permit(:skill_name,:skill_description,:skill_color)
    end
    def admin_verify
        if(!@curent_user.has_role?"admin")
            render :json =>{message:"You are not authorized to perform this action"} , status: 400
            return
        end
    end

end
