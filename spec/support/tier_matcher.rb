RSpec::Matchers.define :have_score do |expected|
  match do |actual|
    actual.calculate_score_from_tier() == expected
  end

  description do
    "champion has score of #{expected} "
  end

  failure_message do |actual|
    "expected champion #{actual.name} to have score #{expected}, was #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected champion #{actual.name} to not have tier #{expected}, but it did"
  end
end