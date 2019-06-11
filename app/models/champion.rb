class Champion < ApplicationRecord
  belongs_to :list, optional: true
  validates :name, :tier, :role, presence: true

  def score_array
    %w[C B A S]
  end

  def calculate_score_from_tier
    if !(score_array.include? tier) || name == '' || name == nil?
      return nil
    end

    score = score_array.index(tier) + 1
    score
  end

  def perform(big_dependency)
    big_dependency.execute
    42
  end
end
