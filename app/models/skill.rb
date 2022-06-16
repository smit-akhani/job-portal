class Skill < ApplicationRecord
    # has_many :taggings, dependent: :destroy

    # has_many :projects, through: :taggings, source: :taggable, source_type: 'Project', dependent: :destroy
    
end
