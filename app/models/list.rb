class List < ApplicationRecord
  has_many :champions, dependent: :destroy
  validates :name, presence: true

  def empty?
    champions.size.equal? 0
  end

  def size
  	size = champions.size
  end
end
