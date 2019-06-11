FactoryBot.define do
  factory :champion do
    name { 'Name' }
    tier { 'S' }
    role { 'ADC' }
    size { 1 }

    trait :invalid_tier do
      tier { 'BadTier' }
    end

    trait :invalid_name do
      name { '' }
    end

    trait :katarina do
      name { 'Katarina' }
      tier { 'C' }
      role { 'Mid' }
    end

    trait :zed do
      name { 'Zed' }
      tier { 'S' }
      role { 'Mid' }
    end

    trait :lucian do
      name { 'Lucian' }
      tier { 'B' }
      role { 'ADC' }
    end

    trait :jax do
      name { 'Jax' }
      tier { 'A' }
      role { 'Top' }
    end

    trait :draven do
      name { 'Draven' }
      tier { 'A' }
      role { 'ADC' }
    end

    trait :ahri do
      name { 'Ahri' }
      tier { 'S' }
      role { 'Mid' }
    end

    trait :hecarim do
      name { 'Hecarim' }
      tier { 'S' }
      role { 'Jungle' }
    end

    trait :jinx do
      name { 'Jinx' }
      tier { 'S' }
      role { 'ADC' }
    end

    trait :lee_sin do
      name { 'Lee Sin' }
      tier { 'S' }
      role { 'Jungle' }
    end

    trait :soraka do
      name { 'Soraka' }
      tier { 'A' }
      role { 'Support' }
    end
  end
end
