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

  it "knows the size of a list" do
  	list.champions << champion
  	expect(list.printSize).to eq(list.champions.size)
  end

  it "can access a champion from a list" do
  	list.champions << champion
  	expect(list.champions[0]).to equal(champion)
  end

end
