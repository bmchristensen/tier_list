require "rails_helper"

RSpec.describe "adding a champion", type: :system do
  it "allows a user to create a list of champions" do
    visit new_list_path
    fill_in "Name", with: "Mid Lane"
    fill_in "Champions", with: "Zed:S\nKatarina:C"
    click_on("Create List")
    visit lists_path
    @list = List.find_by(name: "Mid Lane")
    expect(page).to have_selector(
      "#list_#{@list.id} .name", text: "Mid Lane")
    expect(page).to have_selector(
      "#list_#{@list.id} .size", text: "2")
  end

  it "does not allow a user to create a project without a name" do
    visit new_list_path
    fill_in "Name", with: ""
    fill_in "Champions", with: "Zed:S\nKatarina:C"
    click_on("Create List")
    expect(page).to have_selector(".new_list")
  end
end
