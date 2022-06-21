class UserCvController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_detail
  
    # get All cv of curent user
    # get user_cv/show_all_cv
    def show_all_cv
        @user_cv_list=UserCv.where(users_id: @curent_user.id)
        p @curent_user
        render json: {
            message: "User Cv List Successfully",
            # Serialzer is servise which is used to serialize the data
            # File name ->  app/services/serializer.rb 
            data: Serializer.new.serializer(@user_cv_list,UserCvSerializer)
            } , status: 200
    end
  
    # this method get all cv of curent user and return it to frontend
    # get /user_cv/show
    def show
        @user_cv=UserCv.where(id: params[:id],users_id: @curent_user.id)
        render json: {
            message: "User Cv List Successfully",
            data: Serializer.new.serializer(@user_cv,UserCvSerializer)
            } , status: 200
    end
    # Add new cv to curent user
    # patch /user_cv/add_cv
    def add_cv
        user_cv=UserCv.new(user_cv_params)
        @curent_user.user_cvs<<user_cv
        p @curent_user.save
        if(@curent_user.save)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:user_cv.save!} , status: 400
        end
    end
    # Update exising   cv of curent user 
    # patch /user_cv/:id
    def update
        usercv_obj=UserCv.where(id: params[:id] , users_id: @curent_user.id).first
        if(usercv_obj==nil)
            render :json =>{message:"Id is invlid"} , status: 400
            return
        end
        update_status=usercv_obj.update(user_cv_params)
        
        if(update_status)
            render :json =>{message:"success"} , status: 200
        else 
              render :json =>{message:update_status} , status: 400
        end
    end
    # Delete cv of curent user
    # Delete /user_cv/:id
    def destroy
        x=UserCv.where(id: params[:id] , users_id: @curent_user.id).last
        if(usercv_obj==nil)
            render :json =>{message:"Id is invlid"} , status: 400
            return
        end
        if(x.destroy)
            render :json =>{status:"success"} , status: 200
        else 
              render :json =>{status:x.destroy!} , status: 400
        end

    end
    

    private
    def set_user_detail
        @curent_user=Token.new.get_user_from_token(request)
    end
    def user_cv_params
        params.require(:user_cv).permit(:title,:is_default,:cv)
    end
end
