class UserDetail < ApplicationRecord
    has_one_attached :avatar
    
    belongs_to :user, class_name: "User", foreign_key: "users_id"
end
