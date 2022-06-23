class CompanyDetailsController < ApplicationController
    before_action :authenticate_company!,except: [:resend_confirmation]
    before_action :set_company, except: [:resend_confirmation]
    
    def show
        
        if @company.company_detail
            render json: {
                data: Serializer.new.serializer(current_company.company_detail, CompanyDetailSerializer)
            }, status: 200
        else
            render json: {
                message: "Company details not found"
            }, status: 400
        end
    end

    def create
        p "---------------company_detail_params-------------",company_detail_params
        # @company_detail = CompanyDetail.new(company_detail_params)
        # @address= Address.new(street:params[:company_street],area:params[:company_area],city:params[:company_city],state:params[:company_state],
        #     country:params[:company_country],pincode:params[:company_pincode])
        # @company.company_detail=@company_detail
        # @company.company_detail.address=@address

        @company = @company.build_company_detail(company_detail_params)

        @company.company_detail.images.attach(params[:images])
        
        if @company.save
            render json: {
                message: "Company details saved successfully",
                data: Serializer.new.serializer(@company, CompanyDetailSerializer)
            }, status: 200
        else 
            render json: {
                message: "Something went wrong"
            }, status: 400
        end
    end

    def update
        @company = Company.find_by(id:current_company.id)
        @company.company_detail.images.clear
        @company.company_detail.images.attach(params[:images])
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
    def resend_confirmation
       
        company=Company.find_by(email:params[:email])
     
        if company!=nil
            company.send_confirmation_instructions
            render json: {
                message: "Confirmation mail sent"
                } , status: 200

        else 
            render json: {
                message: "User not found"
            } , status: 404
        end
    end

    private

    def company_detail_params
        # p params[:images][],"-----------------"
        {name:params[:name],about:params[:about],
            phone:params[:phone],logo:params[:logo],
            banner:params[:banner],
            address_attributes:{street:params[:company_street],area:params[:company_area],
                id:params[:attress_id],city:params[:company_city],state:params[:company_state],
                pincode:params[:company_pincode],country:params[:company_country]}}

        # params.permit(:name, :about, :phone, :logo, :banner, :images)
        # , address_attributes: [:id, :street, :area, :city, :state, :country, :pincode]
    end
    def comapny_images_params
        params.permit(images:[])
        # (params[:images] || []).each do |img|
        #     @company.company_detail.images.build(file: img)
        # end
    end
    def set_company
        @company = Token.new.get_company_from_token(request)
    end
end