class CompaniesController < ApplicationController
    def show
      @company = Company.find(params[:id])
      if @company.company_detail.nil?
        render json: {
          message: "No company data found"
        }, status: 400
      else
        render json: @company, status: 400
      end
    end
    
    def index
      @companies = Company.find(CompanyDetail.all.pluck(:company_id))
      if !@companies.nil?
        render json: @companies, status: 200
      end
    end
end