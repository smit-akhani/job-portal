class CompanyDetailsController < ApplicationController
    before_action :authenticate_company!, except: [:index, :show]
    
    def create
        
    end

    def update 

    end

    def destroy

    end
end
