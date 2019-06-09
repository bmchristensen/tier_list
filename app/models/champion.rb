class Champion < ApplicationRecord
  belongs_to :list, optional: true
  validates :name, presence: true
  validates :tier, presence: true

  def score_array
    return ["C", "B", "A", "S"]
  end

  def calculate_score_from_tier
    if !(score_array().include? self.tier) or (self.name == "") or (self.name == nil)
      return nil
    end
    score = score_array().index(self.tier) + 1
    return score
  end

  def perform(big_dependency)
    big_dependency.execute
    return 42
  end
end
