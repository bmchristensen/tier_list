class List < ApplicationRecord
  has_many :champions, dependent: :destroy
  validates :name, presence: true

  def empty?
    champions.size.equal? 0
  end

  def size
  	size = champions.size
  end

  def delete_list
  	self.delete
  end

  def get_list_score
    
    return true
  end
end
