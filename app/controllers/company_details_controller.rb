class CompanyDetailsController < ApplicationController
    before_action :authenticate_company!
    before_action :set_company
    
    def show
        if @company.company_detail
            render json: {
                data: Serializer.new.serializer(@company.company_detail, CompanyDetailSerializer)
            }, status: 200
        else
            render json: {
                message: "Company details not found"
            }, status: 400
        end
    end

    def create
        @company_detail = CompanyDetail.new(company_detail_params)
        @address= Address.new(street:params[:company_street],area:params[:company_area],city:params[:company_city],state:params[:company_state],
            country:params[:company_country],pincode:params[:company_pincode])
        @company.company_detail=@company_detail
        @company.company_detail.address=@address
        if @company.save
            render json: {
                message: "Company details saved successfully",
                data: Serializer.new.serializer(@company_detail, CompanyDetailSerializer)
            }, status: 200
        else 
            render json: {
                message: "Something went wrong"
            }, status: 400
        end
    end

    def update
        if @company.company_detail.update(company_detail_params)
            render json: {
                message: "Company details updated successfully"
            }, status: 200
        else 
            render json: {
                message: "Something went wrong. update unsuccessful"
            }, status: 400
        end
    end

    def destroy
        if @company.company_detail.destroy
            render json: {
                message: "Company details destroyed"
            }, status: 200
        else 
            render json: {
                message: "Something went wrong. destroy unsuccessful"
            }, status: 400
        end
    end

    private

    def company_detail_params
        params.permit(:name, :about, :phone, :logo, :banner, :images)
        # , address_attributes: [:id, :street, :area, :city, :state, :country, :pincode]
    end
    def set_company
        @company = Token.new.get_company_from_token(request)
    end
end