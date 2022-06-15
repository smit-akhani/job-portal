class UserDetailsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_detail
    def show
        temp =UserDetail.find_by(users_id: @curent_user.id)
        render json: temp , status: 200
    end
    def update
        user_detail=UserDetail.find_by(users_id:@curent_user.id)
        user_detail.update(user_detail_params)
    end
    
    private
    def set_user_detail
        @curent_user=Token.new.get_user_from_token(request)
    end
    def user_detail_params
        params.require(:user_detail).permit(:name,:contact_number,:gender,:avatar)  
    end
end
