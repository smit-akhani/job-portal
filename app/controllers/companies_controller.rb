class CompaniesController < ApplicationController
    before_action :authenticate_company!
  
    def show
      company = Token.new.get_company_from_token(request)
      render json: {
        message: "If you see this, you're in! (company)",
        company: company
      }
    end
end