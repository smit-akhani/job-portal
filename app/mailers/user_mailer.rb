class UserMailer < ApplicationMailer
    def demo
        attachments['demo.pdf'] = File.read('app/assets/mailer_data/demo.pdf')
        mail(to: "yash.garala@bacancy.com",
             subject: "You got a new order!")
    end
end
