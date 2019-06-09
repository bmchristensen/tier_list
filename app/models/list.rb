class List < ApplicationRecord
  has_many :champions, dependent: :destroy
  validates :name, presence: true
  validates_with ListValidator, fields: [:size]
    # validates_uniqueness_of :name, scope :list_id

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
<<<<<<< HEAD
                  list_id: self.champions[0].list_id).destroy_all
    add_champion(new_champ)
  end

  def add_champion(champ)
    champions << champ unless champions.include?(champ)
=======
                   list_id: champions[0].list_id).destroy_all
    champions << new_champ
>>>>>>> e2d59e1a30957b107ed1af03b5d562a2b0bf9c03
  end

  def remove_all
    champions.destroy_all
  end

  def remove_list
    destroy
  end
end
