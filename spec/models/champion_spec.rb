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

  it "can calculate its score based on tier" do
    champion = Champion.new(name: "Jax", tier: "A")
    expect(champion.calculate_score_from_tier).to eq(3)
  end
end
