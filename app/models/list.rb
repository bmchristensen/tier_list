class List < ApplicationRecord
  has_many :champions, dependent: :destroy
  validates :name, presence: true
  validates_with ListValidator, fields: [:size]

  def empty?
    champions.size.equal? 0
  end

  def size
    champions.size
  end

  def valid_size?
    size.equal? 5
  end

  def calculate_list_score
    champions.sum(&:calculate_score_from_tier)
  end

  def battle(opposing_team)
    return calculate_list_score < opposing_team.calculate_list_score ? opposing_team : self unless
      calculate_list_score == opposing_team.calculate_list_score do
        nil
      end
  end

  def perform(big_dependency)
    big_dependency.execute
    42
  end

  def replace_champion(existing_champ, new_champ)
    Champion.where(name: existing_champ.name,
                  list_id: self.champions[0].list_id).destroy_all
    self.champions << new_champ
  end

  def remove_all
    self.champions.destroy_all
  end
end
