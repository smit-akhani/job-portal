class JobAlertsController < ApplicationController
    before_action :authenticate_user!
    def index 
        @job_alerts = JobAlert.where(user_id: current_user.id)
        render  json: {
            data: @job_alerts
        } , status: 200
    end

    def create 
        @job_alert = JobAlert.new(job_alert_params)
        @job_alert.user_id = current_user.id
        if @job_alert.save
            render json: {
                message: "Job Alert Updated successfully"
            } , status: 200
        else
            render json: {
                message: "Job Alert not Updated",
                error: @job_alert.errors.full_messages
            } , status: 400
        end
    end

    def update 
        @job_alert = JobAlert.find_by(id: params[:id])
        if @job_alert.update(job_alert_params)
            render json: {
                message: "Job Alert created successfully"
            } , status: 200
        else
            render json: {
                message: "Job Alert not created",
                error: @job_alert.errors.full_messages
            } , status: 400
        end
    end
    def destroy
        @job_alert = JobAlert.find_by(id: params[:id])
        if @job_alert.destroy
            render json: {
                message: "Job Alert deleted successfully"
            } , status: 200
        else
            render json: {
                message: "Job Alert not deleted",
                error: @job_alert.errors.full_messages
            } , status: 400
        end
    end
    
    private
    def job_alert_params
        params.require(:job_alert).permit(:job_title,:location)
    end
end
