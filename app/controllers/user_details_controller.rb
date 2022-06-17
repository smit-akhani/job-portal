class UserDetailsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_detail
    def show
        temp =UserDetail.find_by(users_id: @curent_user.id)
        user_image_url=""
        if temp.avatar.present?
            user_image_url= Rails.application.routes.url_helpers.rails_blob_path(temp.avatar, only_path: true)
        end
        UserMailer.with(temp:temp).demo.deliver_later
        render json: {
            message: "User List with skill",
            # Serialzer is servise which is used to serialize the data
            # File name ->  app/services/serializer.rb 
            data: Serializer.new.serializer(temp.user,UserSerializer),
            user_image_url: user_image_url
            } , status: 200


        # :json => {user_details: temp,:user_image_url=> user_image_url} , status: 200
    end
    def update
        user_detail=UserDetail.find_by(users_id:@curent_user.id)
        user_detail.update(user_detail_params)
        add_skill
        render json: user_detail , status: 200
    end
    
    private
    def set_user_detail
        
        @curent_user=Token.new.get_user_from_token(request)
        p @curent_user
    end
    def user_detail_params
        params.require(:user_detail).permit(:name,:contact_number,:gender,:avatar)  
    end
   def add_skill()
        skil_arr=params[:user_detail][:skill]
        skil_arr=JSON.parse skil_arr
        @curent_user.skill.clear
        skil_arr.each do |x|
            @curent_user.skill<<Skill.find_by(id:x)
        end
        # @curent_user.save
    end
end
