class JobMailer < ApplicationMailer
    # job satus change 
    def job_status_change
        @job_application = params[:job_application]
        bootstrap_mail(to: "yash.garala@bacancy.com",
            subject: "Job Alert!")
    end



end
