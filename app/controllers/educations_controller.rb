class EducationsController < ApplicationController
    before_action :authenticate_user!,except: [:get_user_education]
    before_action :set_user_detail ,except: [:get_user_education]
    before_action :set_education, only: [:show, :update, :destroy]
    def get_user_education
        @educations=Education.where(user_id: params[:id])
        render json: {
            message: "Educations List",
            data: @educations
            } , status: 200
    end
    
    def show
        render json: {
            message: "Show Successfully",
            data: @education
            } , status: 200
    end

    def create
        @education=Education.new(education_params)
        @education.user_id=@curent_user.id
        if(@education.save)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@education.save!} , status: 400
        end
    end
    def update
        
        update_status=@education.update(education_params)
        
        if(update_status)
            render :json =>{message:"success"} , status: 200
        else 
              render :json =>{message:update_status} , status: 400
        end
    end
    def destroy
        # @education=Education.where(id: params[:id],users_id: @curent_user.id).first
       
        if(@education.destroy)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:@education.destroy!} , status: 400
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
    def education_params
        params.require(:education).permit(:school_name,:degree,:field_of_study,:start_date,:end_date,:current,:description)
    end
    def set_education
        if(!@curent_user.has_role?"admin")
            @education=Education.where(id: params[:id],user_id: @curent_user.id).first
        else
            @education=Education.find_by(id: params[:id])
        end
        
    end
end
