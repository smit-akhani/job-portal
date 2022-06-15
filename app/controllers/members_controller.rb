class MembersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      user = Token.new.get_user_from_token(request)
      render json: {
        message: "If you see this, you're in!",
        user: user
      }
    end
end