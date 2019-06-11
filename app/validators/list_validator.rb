class ListValidator < ActiveModel::Validator
  def validate(record)
    uniq_names = record.champions.map do |champ|
      [
        champ.name.downcase
      ]
    end

    uniq_roles = []
    record.champions.map do |champ|
      if champ.role.nil?
        record.errors.add(:champions, 'does not have a role')
      else
        uniq_roles << champ.role.downcase
      end
    end

    if uniq_roles.detect { |x| uniq_roles.count(x) > 1 } != nil
      record.errors.add(:champions, 'cannot have duplicate roles')
    end

    if uniq_names.detect { |x| uniq_names.count(x) > 1 } != nil
      record.errors.add(:champions, 'cannot have duplicate champions')
    end

    if record.size != 5
      record.errors.add(:size, 'Is not 5')
    end
  end
end
