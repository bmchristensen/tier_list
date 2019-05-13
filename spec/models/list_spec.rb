require "rails_helper"

RSpec.describe List do
  let(:list) { FactoryBot.build_stubbed(:list) }
  let(:list2) { FactoryBot.build_stubbed(:list) }
  let(:list3) { FactoryBot.build_stubbed(:list) }
  let(:katarina) { FactoryBot.build(:champion, :katarina)}
  let(:zed) { FactoryBot.build(:champion, :zed)}
  let(:jax) { FactoryBot.build(:champion, :jax)}
  let(:lucian) { FactoryBot.build(:champion, :lucian)}
  let(:azir) { FactoryBot.build(:champion, :azir)}
  let(:lee_sin) { FactoryBot.build(:champion, :lee_sin)}
  let(:hecarim) { FactoryBot.build(:champion, :hecarim)}
  let(:jinx) { FactoryBot.build(:champion, :jinx)}
  let(:draven) { FactoryBot.build(:champion, :draven)}
  let(:ahri) { FactoryBot.build(:champion, :ahri)}

  it "creates an empty list upon instantiation" do
    expect(list.empty?).to be_truthy
  end

  it "can add a champion to a list" do
    list.champions << katarina
    expect(list.size()).to eq(1)
  end

  it "knows the size of a list" do
    list.champions << katarina
    list.champions << zed
    list.champions << jax
    expect(list.size()).to eq(3)
  end

  it "can access a champion from a list" do
    list.champions << katarina
    expect(list.champions[0]).to equal(katarina)
  end

  it "can calculate the total score for a list" do
    list.champions << jax
    list.champions << katarina
    list.champions << draven

    expect(list).to have_total_score(7)
    expect(list).not_to have_total_score(4)
  end

  it "can calculate which list has a better score" do
    list.champions << jax
    list.champions << katarina
    list.champions << draven

    list2.champions << hecarim
    list2.champions << zed
    list2.champions << lucian

    expect(list).to have_total_score(7)
    expect(list2).to have_total_score(10)
    expect(list.battle(list2)).to eq(list2)

    list3.champions << lee_sin
    list3.champions << ahri
    list3.champions << jinx

    expect(list3).to have_total_score(12)
    expect(list3.battle(list2)).to eq(list3)
  end

  it "does not return a winner if two lists have equal scores" do
    list.champions << jax
    list.champions << ahri
    list.champions << draven

    list2.champions << hecarim
    list2.champions << zed
    list2.champions << lucian

    expect(list.battle(list2)).to eq(nil);
  end
end

