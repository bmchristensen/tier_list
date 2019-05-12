require "rails_helper"

RSpec.describe List do
  let(:list) { FactoryBot.build_stubbed(:list) }
  let(:list2) { FactoryBot.build_stubbed(:list) }
  let(:list3) { FactoryBot.build_stubbed(:list) }
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

  it "can calculate the total score for a list" do
    list.champions << Champion.new(name: "Jax", tier: "A")
    list.champions << Champion.new(name: "Katarina", tier: "C")
    list.champions << Champion.new(name: "Draven", tier: "A")

    expect(list).to have_total_score(7)
    expect(list).not_to have_total_score(4)
  end

  it "can calculate which list has a better score" do
    list.champions << Champion.new(name: "Jax", tier: "A")
    list.champions << Champion.new(name: "Katarina", tier: "C")
    list.champions << Champion.new(name: "Draven", tier: "A")

    list2.champions << Champion.new(name: "Hecarim", tier: "S")
    list2.champions << Champion.new(name: "Zed", tier: "S")
    list2.champions << Champion.new(name: "Lucian", tier: "B")

    expect(list).to have_total_score(7)
    expect(list2).to have_total_score(10)
    expect(list.battle(list2)).to eq(list2)

    list3.champions << Champion.new(name: "Lee Sin", tier: "S")
    list3.champions << Champion.new(name: "Ahri", tier: "S")
    list3.champions << Champion.new(name: "Jinx", tier:"S")

    expect(list3).to have_total_score(12)
    expect(list3.battle(list2)).to eq(list3)
  end

  it "does not return a winner if two lists have equal scores" do
    list.champions << Champion.new(name: "Jax", tier: "A")
    list.champions << Champion.new(name: "Ahri", tier: "S")
    list.champions << Champion.new(name: "Draven", tier: "A")

    list2.champions << Champion.new(name: "Hecarim", tier: "S")
    list2.champions << Champion.new(name: "Zed", tier: "S")
    list2.champions << Champion.new(name: "Lucian", tier: "B")

    expect(list.battle(list2)).to eq(nil);
  end
end

