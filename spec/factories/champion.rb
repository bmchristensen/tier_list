FactoryBot.define do
  factory :champion do

  	name {"champion_name"}
  	tier {"S"}
  	size {1}
  	
  	trait :katarina do
  	  name {"Katarina"}
  	  tier {"C"}
  	  size {1}
  	end

  	trait :zed do
  	  name {"Zed"}
  	  tier {"S"}
  	  size {1}
  	end

  	trait :jax do
  	  name {"Jax"}
  	  tier {"A"}
  	  size {1}
  	end

  	trait :lucian do
  	  name {"Lucian"}
  	  tier {"B"}
  	  size {1}
  	end

  	trait :azir do
  	  name {"Azir"}
  	  tier {"C"}
  	  size {1}
  	end

  	trait :draven do
  	  name {"Draven"}
  	  tier {"A"}
  	  size {1}
  	end

  	trait :lee_sin do
  	  name {"Lee Sin"}
  	  tier {"S"}
  	  size {1}
  	end

  	trait :hecarim do
  	  name {"Hecarim"}
  	  tier {"S"}
  	  size {1}
  	end

  	trait :jinx do
  	  name {"Jinx"}
  	  tier {"S"}
  	  size {1}
  	end

  	trait :ahri do
  	  name {"Ahri"}
  	  tier {"S"}
  	  size {1}
  	end

  	trait :champion_with_poor_tier do
  	  name {"champion_with_poor_tier"}
  	  tier {"BAD_TIER"}
  	  size {1}
  	end

  	trait :champion_with_no_name do
  	  name {""}
  	  tier {"A"}
  	  size {1}
  	end

  	trait :champion_with_nil_name do
  	  name {nil}
  	  tier {"A"}
  	  size {1}
  	end

  end
end

