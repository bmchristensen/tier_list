require "rails_helper"

RSpec.describe List do
  let(:list) { List.new }
  let(:champion) { Champion.new }
  
  it "creates an empty list upon instantiation" do
    expect(list.empty?).to be_truthy
  end

  it "can add a champion to a list" do
    list.champions << champion
    expect(list.champions.size).to eq(1)
  end
end
