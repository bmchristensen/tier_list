class List < ApplicationRecord
  has_many :champions, dependent: :destroy
  validates :name, presence: true

  def empty?
    champions.size.equal? 0
  end

  def size
    size = champions.size
  end

  def calculate_list_score
    champions.sum(&:calculate_score_from_tier)
  end

  def battle(opposing_team)
    if self.calculate_list_score == opposing_team.calculate_list_score
      return nil
    else
      self.calculate_list_score < opposing_team.calculate_list_score ?
        opposing_team : self
    end
  end

  def perform(big_dependency)
    big_dependency.execute
    return 42
  end
end
