class JobApplicationSerializer < ActiveModel::Serializer
  attributes :id,:status ,:apply_date,:feedback,:user_resume_url
  
end
