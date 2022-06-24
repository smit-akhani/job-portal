require 'faker'
require 'set'

begin
    user=User.create!(email:"admin@admin.com",password:"123456",password_confirmation:"123456")
    user.add_role :admin
    
rescue => e
    p "Admin user already exists"
end

50.times do
    Skill.create(skill_name: Faker::Job.key_skill,skill_color:Faker::Color.hex_color)
end
# NOTE create new user
20.times do
    user=User.new(email:Faker::Internet.email,password:"123456",password_confirmation:"123456")
    user.skip_confirmation!
    user.save!

    user.save!

    s1=Set.new
    while(s1.size()<=3)
        begin
            temp=Skill.all.sample
            s1.add(temp)
            user.skill_matches.create!(skill: temp)
        rescue => e
        end
    end
    
    temp_user_cv=user.user_cvs.new 
    temp_user_cv.cv.attach(io:File.open("app/assets/test.pdf"), filename: "test.pdf", content_type: "application/pdf")
    temp_user_cv.is_default=false
    # user.user_cvs.create(cv:File.open("app/assets/test.pdf"),is_default:false)
    user.educations.create!(school_name: Faker::Educator.university, degree: Faker::Educator.degree,
        field_of_study:Faker::Educator.course_name,
        start_date:Faker::Date.between(from: '2010-01-01', to: '2015-01-01'),end_date: Faker::Date.between(from: '2015-01-01', to: '2020-01-01'),
        description:Faker::Lorem.paragraph,current:false)
    user.experiences.create!(company_name:Faker::Company.name,title: Faker::Job.title,employment_type:Faker::Job.employment_type,location:Faker::Address.city,
        start_date:Faker::Date.between(from: '2010-01-01', to: '2015-01-01'),end_date:Faker::Date.between(from: '2015-01-01', to: '2020-01-01'),
        current:false,description:Faker::Lorem.paragraph)

    user.save
    address=Address.new(street: Faker::Address.street_name,area:Faker::Address.street_address,
        city:Faker::Address.city,state:Faker::Address.state,country:Faker::Address.country,pincode:Faker::Address.zip_code)

    user_detail=UserDetail.new(user:user,name:Faker::Name.name,contact_number:Faker::PhoneNumber.subscriber_number(length: 10),
        gender:Faker::Boolean.boolean,address:address)
        user_detail.avatar.attach(io:File.open("app/assets/demo.jpeg"), filename: "demo.jpeg", content_type: "image/jpeg")
    user_detail.save!  
end

# NOTE company 

1.times do
    company=Company.new(email:Faker::Internet.email,password:"123456",password_confirmation:"123456")
    company.skip_confirmation!
    company.save
    
    address=Address.new(street: Faker::Address.street_name,area:Faker::Address.street_address,
        city:Faker::Address.city,state:Faker::Address.state,country:Faker::Address.country,pincode:Faker::Address.zip_code)
    
    company_detail=CompanyDetail.new(company:company,name:Faker::Company.name,phone:Faker::PhoneNumber.subscriber_number(length: 10),
        address:address,about:Faker::Lorem.paragraph)
        company_detail.logo.attach(io:File.open('app/assets/no_logo.png'), filename: "no_logo.png", content_type: "image/png")
    company_detail.save
end


# NOTE job 
30.times do
  Job.create!(company:Company.all.sample,job_title:Faker::Job.title,job_description:Faker::Lorem.paragraph,
    year_of_exp:Faker::Number.between(from: 1, to: 10),location:Faker::Address.city,last_date_to_apply:Faker::Date.between(from: '2020-01-01', to: '2025-01-01'),
    easy_apply:false)

end


# NOTE job application

20.times do
    user=User.all.sample
    if(user.user_cvs.count()>0)
        JobApplication.create(job:Job.all.sample,user:user,user_cv_id:user.user_cvs.first.id)
    end
end

10.times do 
    SaveJob.create(job:Job.all.sample,user:User.all.sample)
end
