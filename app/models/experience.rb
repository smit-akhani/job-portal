class Experience < ApplicationRecord
    belongs_to :user 
    has_many :skill_matches, as: :matchable, dependent: :destroy 
    has_many :skill ,through: "skill_matches", dependent: :destroy
    validates :title,:company_name,:start_date,presence: true
    validates :end_date,presence: true, if: :check_current
    
    def check_current
        self.current==false
    end
end
