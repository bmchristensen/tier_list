require 'rails_helper'

RSpec.describe List do
  let(:team1) { build_stubbed(:list, name: 'Empty Team', champions: []) }
  let(:team2) do
    build_stubbed(
      :list,
      name: 'Real Team',
      champions: [build(:champion, :lee_sin),
                  build(:champion, :ahri),
                  build(:champion, :jinx),
                  build(:champion, :zed),
                  build(:champion, :jax)]
    )
  end

  it 'cannot create an empty team' do
    expect(team1).to be_invalid
  end

  it 'can add a champion to a list' do
    expect(team1.size).to eq(0)
    team1.champions << build(:champion, :zed)
    expect(team1.size).to eq(1)
  end

  it 'can access a champion from a list' do
    team1.champions << build(:champion, :zed)
    expect(team1.champions[0].name).to eq('Zed')
  end

  it 'can calculate the total score for a list' do
    expect(team1).to have_total_score(0)
    expect(team2).to have_total_score(19)
  end

  it 'can calculate which list has a better score' do
    expect(team1.battle(team2)).to eq(team2)
  end

  it 'does not return a winner if two lists have equal scores' do
    team1.champions << [
      build(:champion, :hecarim),
      build(:champion, :draven),
      build(:champion, :zed),
      build(:champion, :ahri),
      build(:champion, :lee_sin)
    ]
    expect(team1.battle(team2)).to eq(nil)
  end

  it 'is not valid if size is not five' do
    expect(team2.valid?).to be_truthy
    team2.champions = []
    expect(team2.valid?).to be_falsey
  end

  describe 'fakes and mocks:' do
    let(:big_dependency) { BigDependency.new }
    let(:list_stub) { List.new }
    let(:list_mock) { List.new }

    it 'returns the correct value from perform method using instance double' do
      instance_twin = instance_double(List)
      expect(instance_twin).to receive(:perform).and_return(42)
      expect(instance_twin.perform(big_dependency)).to eq(42)
    end

    it 'returns the correct value from its perform method using a stub' do
      allow(list_stub).to receive(:perform).and_return(42)
      expect(list_stub.perform(big_dependency)).to eq(42)
    end

    it 'returns the correct value from its perform method using a mock' do
      allow(list_stub).to receive(:perform).and_return(42)
      expect(list_stub.perform(big_dependency)).to eq(42)
    end
  end
end
