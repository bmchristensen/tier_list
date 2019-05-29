class ListValidator < ActiveModel::Validator
  def validate(record)
    if record.size != 5
      record.errors.add(:size, "Is not 5")
    end
  end
end
