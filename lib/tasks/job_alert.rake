task :job_alert  => :environment do
    job_alerts =JobAlert.all
    job_alerts.each do |job_alert|
        concat_location_title=job_alert.job_title
        @x= Job.search_job(concat_location_title)
        UserMailer.with(jobs:@x).send_alert.deliver_now if(@x.size()!=0)
    end
end