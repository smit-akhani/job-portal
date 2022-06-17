class UserMailer < ApplicationMailer
    def demo
        mail(to: "yashgarala29@gmail.com", subject: "You got a new order!")


    end
end
