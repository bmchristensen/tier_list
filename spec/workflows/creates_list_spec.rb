require "rails_helper"

RSpec.describe CreatesList do
  let(:creator) { CreatesList.new(
    name: "Mid Lane", champ_string: champ_string) }

  describe "initialization" do
    let(:champ_string) { "" }
    it "creates a list given a name" do
      creator.build
      expect(creator.list.name).to eq("Mid Lane")
    end
  end

  describe "champion string parsing" do
    let(:champions) { creator.convert_string_to_champion }

    describe "with a string with tier" do
      let(:champ_string) { "Zed:S" }
      specify { expect(champions.size).to eq(1) }
      specify { expect(champions.first).to have_attributes(
        name: "Zed", tier: "S") }
    end

    describe "with multiple champions" do
      let(:champ_string) { "Zed:S\nKatarina:C" }
      specify { expect(champions.size).to eq(2) }
      specify { expect(champions).to match(
        [an_object_having_attributes(name: "Zed", tier: "S"),
         an_object_having_attributes(name: "Katarina", tier: "C")]) }
    end

    describe "attaches champions to the list" do
      let(:champ_string) { "Zed:S\nKatarina:C" }
      before(:example) { creator.create }
      specify { expect(creator.list.champions.size).to eq(2) }
      specify { expect(creator.list).not_to be_a_new_record }
    end
  end

  describe "failure cases" do
    let(:champions) { creator.convert_string_to_champion }

    describe "fails when trying to save a project with no name" do
      let(:name) { "" }
      let(:champ_string) { "" }
      specify { expect(creator).not_to be_a_success }
    end

    describe "fails when trying to save a project with a single string" do
      let(:name) { "Mid Lane" }
      let(:champ_string) { "Zed" }
      specify { expect(creator).not_to be_a_success }
    end
  end
end
