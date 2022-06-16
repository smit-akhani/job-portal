class UserCv < ApplicationRecord
    attr_accessor :cv_url
    # cv_url="Yash"
    has_one_attached :cv
    
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    def cv_url
        
        Rails.application.routes.url_helpers.rails_blob_path(self.cv, only_path: true)
        
    end
end
