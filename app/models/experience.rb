class Experience < ApplicationRecord
    belongs_to :user 
    has_many :skill_matches, as: :matchable, dependent: :destroy 
    has_many :skill ,through: "skill_matches", dependent: :destroy
   
end
