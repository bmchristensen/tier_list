require 'rails_helper'

RSpec.describe CreatesList do
  let(:creator) { CreatesList.new(name: 'Mid Lane', champ_string: champ_string) }

  describe 'initialization' do
    let(:champ_string) { '' }
    it 'creates a list given a name' do
      creator.build
      expect(creator.list.name).to eq('Mid Lane')
    end
  end

  describe 'champion string parsing' do
    let(:champions) { creator.convert_string_to_champion }

    describe 'with a chamption and tier and role' do
      let(:champ_string) { 'Zed:S:Mid' }
      specify { expect(champions.size).to eq(1) }
      specify { expect(champions.first).to have_attributes(name: 'Zed', tier: 'S', role: 'Mid') }
    end

    describe 'with multiple champions' do
      let(:champ_string) { "Zed:S:Mid\nKatarina:C:Mid" }
      specify { expect(champions.size).to eq(2) }
      specify do
        expect(champions).to match(
          [an_object_having_attributes(name: 'Zed', tier: 'S'),
           an_object_having_attributes(name: 'Katarina', tier: 'C')]
        )
      end
    end

    describe 'attaches champions to the list' do
      let(:champ_string) { "Zed:S:Mid\nKatarina:C:Mid\nJinx:A:ADC\nLee_Sin:B:Jungle\nAhri:S:Mid" }
      before(:example) { creator.create }
      specify { expect(creator.list.champions.size).to eq(5) }
      specify { expect(creator.list).not_to be_a_new_record }
    end
  end

  describe 'failure cases' do
    let(:champions) { creator.convert_string_to_champion }

    describe 'fails when trying to save a project with no name' do
      let(:name) { '' }
      let(:champ_string) { '' }
      specify { expect(creator).not_to be_a_success }
    end

    describe 'fails when trying to save a project with a single string' do
      let(:name) { 'Mid Lane' }
      let(:champ_string) { 'Zed' }
      specify { expect(creator).not_to be_a_success }
    end
  end
end
