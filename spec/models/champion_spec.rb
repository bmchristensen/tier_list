require 'rails_helper'

RSpec.describe Champion, type: :model do
  let(:katarina) { FactoryBot.build_stubbed(:champion, :katarina)}
  let(:zed) { FactoryBot.build_stubbed(:champion, :zed)}
  let(:jax) { FactoryBot.build_stubbed(:champion, :jax)}
  let(:lucian) { FactoryBot.build_stubbed(:champion, :lucian)}
  let(:azir) { FactoryBot.build_stubbed(:champion, :azir)}
  let(:champion_with_poor_tier) { FactoryBot.build_stubbed(:champion, :champion_with_poor_tier)}
  let(:champion_with_no_name) { FactoryBot.build_stubbed(:champion, :champion_with_no_name)}
  let(:champion_with_nil_name) { FactoryBot.build_stubbed(:champion, :champion_with_nil_name)}
  it "has a name attribute" do
    expect(jax).to respond_to(:name)
  end

  it "has a tier attribute" do
    expect(jax).to respond_to(:tier)
  end

  it "can calculate champion score based on tier" do
    expect(jax).to have_score(3)
    expect(zed).to have_score(4)
  end

  it "does not calculate a score with a poor tier input" do
    champion1 = Champion.new(name: "Jax", tier: "BadTier")
    expect(champion_with_poor_tier).to have_score(nil)
  end

  it "does not calculate a score with a poor name input" do
    expect(champion_with_no_name).to have_score(nil)
    expect(champion_with_nil_name).to have_score(nil)
  end

  it "can calculate champion score based on all tiers C, B, A, and S (scores 1-4 respectively)" do
    expect(azir).to have_score(1)
    expect(lucian).to have_score(2)
    expect(jax).to have_score(3)
    expect(zed).to have_score(4)
  end

  it "creates a Kat with Factory and RSPEC let" do
    expect(katarina).to respond_to(:name)
  end
end
