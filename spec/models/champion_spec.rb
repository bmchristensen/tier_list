require 'rails_helper'

RSpec.describe Champion, type: :model do
  it "has a name attribute" do
    champion = Champion.new(name: "Jax", tier: "A")
    expect(champion).to respond_to(:name)
  end

  it "has a tier attribute" do
    champion = Champion.new(name: "Jax", tier: "A")
    expect(champion).to respond_to(:tier)
  end

  it "can calculate champion score based on tier" do
    champion1 = Champion.new(name: "Jax", tier: "A")
    expect(champion1).to be_of_champion_score(3)
    champion2 = Champion.new(name: "Zed", tier: "S")
    expect(champion2).to be_of_champion_score(4)
  end

  it "does not calculate a score with a poor tier input" do
    champion = Champion.new(name: "Jax", tier: "BadTier")
    expect(champion).to be_of_champion_score(nil)
  end

  it "does not calculate a score with a poor name input" do
    champion1 = Champion.new(name: "", tier: "S")
    expect(champion1).to be_of_champion_score(nil)
    champion2 = Champion.new(name: nil, tier: "S")
    expect(champion2).to be_of_champion_score(nil)
  end

  it "can calculate champion score based on all tiers C, B, A, and S (scores 1-4 respectively)" do
    champion1 = Champion.new(name: "Katarina", tier: "C")
    champion2 = Champion.new(name: "Lucian", tier: "B")
    champion3 = Champion.new(name: "Jax", tier: "A")
    champion4 = Champion.new(name: "Zed", tier: "S")
    expect(champion1).to be_of_champion_score(1)
    expect(champion2).to be_of_champion_score(2)
    expect(champion3).to be_of_champion_score(3)
    expect(champion4).to be_of_champion_score(4)
  end
end
