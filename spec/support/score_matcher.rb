RSpec::Matchers.define :have_total_score do |expected|
  match do |actual|
    actual.calculate_list_score() == expected
  end

  description do
    "have list totaling #{expected} points"
  end

  failure_message do |actual|
    "expected list #{actual.name} to have score #{expected}, was #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected list #{actual.name} to not have score #{expected}, but it did"
  end
end
