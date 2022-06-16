class Skill < ApplicationRecord
    has_many :skill_matches, dependent: :destroy

    has_many :users, through: :skill_matches, source: :matchable, source_type: 'User', dependent: :destroy
    
end
