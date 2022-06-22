class Education < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    validates :school_name,:degree,:start_date ,presence: true
    validates :end_date,presence: true, if: :check_current
    def check_current
        self.current==false
    end
end
