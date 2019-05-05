class Champion < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  validates :tier, presence: true

  def score_array
    return ["C", "B", "A", "S"]
  end

  def calculate_score_from_tier
    score_array()
    score = score_array.index(self.tier) + 1
    return score
  end
end
