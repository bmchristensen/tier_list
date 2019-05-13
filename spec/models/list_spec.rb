require "rails_helper"

RSpec.describe List do
  let(:empty_team) { FactoryBot.build_stubbed(:list) }
  let(:team_of_one) { FactoryBot.build_stubbed(:list, champions: [champion]) }
  let(:team_of_three) { FactoryBot.build_stubbed(:list, champions: [champion, champion, champion]) }
  let(:team1) { FactoryBot.build_stubbed(:list, champions: [jax, katarina, draven]) }
  let(:team2) { FactoryBot.build_stubbed(:list, champions: [hecarim, zed, lucian]) }
  let(:team3) { FactoryBot.build_stubbed(:list, champions: [lee_sin, ahri, jinx]) }
  let(:first_10pt_team) { FactoryBot.build_stubbed(:list, champions: [jax, ahri, draven]) }
  let(:second_10pt_team) { FactoryBot.build_stubbed(:list, champions: [hecarim, zed, lucian]) }
  let(:champion) { FactoryBot.build_stubbed(:champion) }
  let(:jax) { FactoryBot.build_stubbed(:champion, :jax) }
  let(:katarina) { FactoryBot.build_stubbed(:champion, :katarina) }
  let(:draven) { FactoryBot.build_stubbed(:champion, :draven) }
  let(:hecarim) { FactoryBot.build_stubbed(:champion, :hecarim) }
  let(:zed) { FactoryBot.build_stubbed(:champion, :zed) }
  let(:lucian) { FactoryBot.build_stubbed(:champion, :lucian) }
  let(:lee_sin) { FactoryBot.build_stubbed(:champion, :lee_sin) }
  let(:ahri) { FactoryBot.build_stubbed(:champion, :ahri) }
  let(:jinx) { FactoryBot.build_stubbed(:champion, :jinx) }

  it "creates an empty list upon instantiation" do
    expect(empty_team.empty?).to be_truthy
  end

  it "can add a champion to a list" do
    expect(team_of_one.size()).to eq(1)
  end

  it "knows the size of a list" do
    expect(team_of_three.size()).to eq(3)
  end

  it "can access a champion from a list" do
    expect(team_of_one.champions[0]).to equal(champion)
  end

  it "can calculate the total score for a list" do
    expect(team1).to have_total_score(7)
    expect(team1).not_to have_total_score(4)
  end

  it "can calculate which list has a better score" do
    expect(team1).to have_total_score(7)
    expect(team2).to have_total_score(10)
    expect(team1.battle(team2)).to eq(team2)
    expect(team3).to have_total_score(12)
    expect(team3.battle(team2)).to eq(team3)
  end

  it "does not return a winner if two lists have equal scores" do
    expect(first_10pt_team.battle(second_10pt_team)).to eq(nil);
  end
end

