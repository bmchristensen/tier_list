FactoryBot.define do
	factory :champion do
		name { "Name" }
		tier { "S" }
		size { 1 }

		trait :invalid_tier do
			tier { "BadTier" }
		end

		trait :invalid_name do
			name {""}
		end

		trait :katarina do
			name { "Katarina" }
			tier { "C" }
		end

		trait :zed do
			name { "Zed" }
			tier { "S" }
		end

		trait :lucian do
			name { "Lucian" }
			tier { "B" }
		end

		trait :jax do
			name { "Jax" }
			tier { "A" }
		end

		trait :draven do
			name { "Draven" }
			tier { "A" }
		end

		trait :ahri do
			name { "Ahri" }
			tier { "S" }
		end

		trait :hecarim do
			name { "Hecarim" }
			tier { "S" }
		end

		trait :jinx do
			name { "Jinx" }
			tier { "S" }
		end

		trait :lee_sin do
			name { "Lee Sin" }
			tier { "S" }
		end
	end
end
