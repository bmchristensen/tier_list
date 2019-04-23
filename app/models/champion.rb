class Champion < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  validates :tier, presence: true
end
