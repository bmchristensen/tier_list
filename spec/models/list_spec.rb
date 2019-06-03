require 'rails_helper'

RSpec.describe List do
  let(:empty_team) { build_stubbed(:list, name: 'Empty Team', champions: []) }
  let(:valid_team) do
    build_stubbed(
      :list,
      name: 'Valid Team',
      champions: [build_stubbed(:champion, :lee_sin),
                  build_stubbed(:champion, :ahri),
                  build_stubbed(:champion, :jinx),
                  build_stubbed(:champion, :zed),
                  build_stubbed(:champion, :jax)]
    )
  end

  let(:team_for_replace_method) do
    create(
      :list,
      name: 'Real Team',
      champions: [create(:champion, :lee_sin),
                  create(:champion, :ahri),
                  create(:champion, :jinx),
                  create(:champion, :zed),
                  create(:champion, :jax)]
    )
  end

  it 'cannot create an empty team' do
    expect(empty_team).to be_invalid
  end

  it 'can add a champion to a list' do
    expect(empty_team.size).to eq(0)
    empty_team.champions << build(:champion, :zed)
    expect(empty_team.size).to eq(1)
  end

  it 'can access a champion from a list' do
    empty_team.champions << build(:champion, :zed)
    expect(empty_team.champions[0].name).to eq('Zed')
  end

  it 'can calculate the total score for a list' do
    expect(empty_team).to have_total_score(0)
    expect(valid_team).to have_total_score(19)
  end

  it 'can calculate which list has a better score' do
    expect(empty_team.battle(valid_team)).to eq(valid_team)
  end

  it 'does not return a winner if two lists have equal scores' do
    empty_team.champions << [
      build(:champion, :hecarim),
      build(:champion, :draven),
      build(:champion, :zed),
      build(:champion, :ahri),
      build(:champion, :lee_sin)
    ]
    expect(empty_team.battle(valid_team)).to eq(nil)
  end

  it 'is not valid if size is not five' do
    expect(valid_team.valid?).to be_truthy
    # valid_team.champions = []
    expect(empty_team.valid?).to be_falsey
  end

  it 'can replace a champion in its list' do
    existing_hero = build(:champion, :zed)
    new_hero = build(:champion, :hecarim)
    team_for_replace_method.replace_champion(existing_hero, new_hero)
    # valid_team.reload
    expect(team_for_replace_method.champions.include?(new_hero)).to be_truthy
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
