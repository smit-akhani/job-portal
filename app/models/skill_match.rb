class SkillMatch < ApplicationRecord
    belongs_to :matchable, :polymorphic =>true, optional: true
    belongs_to :skill
end
