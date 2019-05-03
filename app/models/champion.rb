class Champion < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  validates :tier, presence: true


  def calculate_champion_score
  	score_array = ["C","B","A","S"]
  	if score_array.any? { |n| n == self.tier }
  		score = score_array.index(self.tier) + 1
  		return score
  	else
  		return 0
  	end
  end
end
