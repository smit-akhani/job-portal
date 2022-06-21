class Skill < ApplicationRecord
    has_many :skill_matches, dependent: :destroy

    has_many :users, through: :skill_matches, source: :matchable, source_type: 'User', dependent: :destroy
    has_many :eperience, through: :skill_matches, source: :matchable, source_type: 'Experience', dependent: :destroy
    has_many :job, through: :skill_matches, source: :matchable, source_type: 'Experience', dependent: :destroy
    
    
end
