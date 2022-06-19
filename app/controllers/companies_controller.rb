class CompaniesController < ApplicationController
    before_action :authenticate_company!, except: [:index, :show]

    def show
      if current_company 
        @company = Token.new.get_company_from_token(request)
        render json: {
          message: "If you see this, you're in! (company)",
          company: @company
        }
      elsif current_user
        @user = Token.new.get_user_from_token(request)
        render json: {
          message: "you are in as a user"
        }
      else
        render json: {
          message: "not logged in"
        }
      end
    end
end