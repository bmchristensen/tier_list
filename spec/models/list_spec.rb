require 'rails_helper'

RSpec.describe List do
  let(:empty_team) { build_stubbed(:list, name: 'Empty Team', champions: []) }
  let(:valid_team) do
    build_stubbed(
      :list,
      name: 'Valid Team',
      champions: [build_stubbed(:champion, :katarina),
                  build_stubbed(:champion, :lucian),
                  build_stubbed(:champion, :hecarim),
                  build_stubbed(:champion, :soraka),
                  build_stubbed(:champion, :jax)]
    )
  end

  let(:duplicate_team) do
    build_stubbed(
      :list,
      name: 'Duplicate Team',
      champions: [create(:champion, :lee_sin),
                  create(:champion, :lee_sin),
                  create(:champion, :zed),
                  create(:champion, :zed),
                  create(:champion, :zed)]
    )
  end

  let(:db_backed_team) do
    create(
      :list,
      name: 'Real Team',
      champions: [create(:champion, :katarina),
                  create(:champion, :lucian),
                  create(:champion, :hecarim),
                  create(:champion, :soraka),
                  create(:champion, :jax)]
    )
  end

  it 'can create valid teams' do
    expect(valid_team).to be_valid
    expect(db_backed_team).to be_valid
  end

  it 'cannot create an empty team' do
    expect(empty_team).to be_invalid
  end

  it 'cannot create a team with duplicates' do
    expect(duplicate_team).to be_invalid
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
    expect(valid_team).to have_total_score(13)
  end

  it 'can calculate which list has a better score' do
    expect(empty_team.battle(valid_team)).to eq(valid_team)
  end

  it 'does not return a winner if two lists have equal scores' do
    empty_team.champions << [
      build(:champion, :katarina),
      build(:champion, :lucian),
      build(:champion, :hecarim),
      build(:champion, :soraka),
      build(:champion, :jax)
    ]
    expect(empty_team.battle(valid_team)).to eq(nil)
  end

  it 'cannot add duplicate champions' do
    draven = build(:champion, :draven)
    zed = build(:champion, :zed)
    lee_sin = build(:champion, :lee_sin)
    empty_team.add_champion(draven)
    empty_team.add_champion(draven)
    empty_team.add_champion(zed)
    empty_team.add_champion(zed)
    empty_team.add_champion(lee_sin)
    expect(empty_team).to be_invalid
  end

  it 'is not valid if size is not five' do
    db_backed_team.remove_all
    expect(db_backed_team.size).to be(0)
    expect(db_backed_team.valid?).to be_falsey
  end

  it 'can replace a champion in its list' do
    existing_hero = create(:champion, :zed)
    new_hero = create(:champion, :hecarim)
    db_backed_team.replace_champion(existing_hero, new_hero)
    db_backed_team.reload
    expect(db_backed_team.champions.include?(new_hero)).to be_truthy
    expect(db_backed_team.champions.include?(existing_hero)).to be_falsey
  end

  it 'can delete a list of champions' do
    db_backed_team.remove_list
    expect(db_backed_team.valid?).to be_falsey
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
