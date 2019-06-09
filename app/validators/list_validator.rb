class ListValidator < ActiveModel::Validator
  def validate(record)
    uniq_attrs = record.champions.map do |x|
      [
        x.name.downcase
      ]
    end

    if uniq_attrs.detect{ |x| uniq_attrs.count(x) > 1} != nil
      record.errors.add(:champions, "cannot have duplicates")
    end

    if record.size != 5
      record.errors.add(:size, "Is not 5")
    end
  end
end
