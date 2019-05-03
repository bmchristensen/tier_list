require "rails_helper"

RSpec.describe List do
  let(:list) { List.new }
  let(:champion) { Champion.new }

  it "creates an empty list upon instantiation" do
    expect(list.empty?).to be_truthy
  end

  it "can add a champion to a list" do
    list.champions << champion
    expect(list.size()).to eq(1)
  end

  it "knows the size of a list" do
    list.champions << champion
    list.champions << champion
    list.champions << champion
    expect(list.size()).to eq(3)
  end

  it "can access a champion from a list" do
    list.champions << champion
    expect(list.champions[0]).to equal(champion)
  end

  it "can calculate a champion score" do
    champion.name = "Katarina"
    champion.tier = "C"
    expect(champion.calculate_champion_score).to eq(1)
    champion.tier = "S"
    expect(champion.calculate_champion_score).to eq(4)
  end

  it "will default to champion score 0 with tier input other than C, B, A, or S" do
    champion.name = "Katarina"
    champion.tier = "Zed"
    expect(champion.calculate_champion_score).to eq(0)
  end
end

