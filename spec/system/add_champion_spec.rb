require 'rails_helper'

RSpec.describe 'adding a champion', type: :system do
  it 'allows a user to create a valid list of champions' do
    visit new_list_path
    fill_in 'Name', with: 'Mid Lane'
    fill_in 'Champions', with: "Katarina:C:Mid
                                Lucian:B:ADC
                                Hecarim:S:Jungle
                                Soraka:A:Support
                                Jax:A:Top"
    click_on('Create List')
    visit lists_path
    @list = List.find_by(name: 'Mid Lane')
    expect(page).to have_selector("#list_#{@list.id} .name", text: 'Mid Lane')
    expect(page).to have_selector("#list_#{@list.id} .size", text: '5')
  end

  it 'does not allow a user to create a list without a name' do
    visit new_list_path
    fill_in 'Name', with: ''
    fill_in 'Champions', with: "Zed:S:Mid\nKatarina:C:Mid"
    click_on('Create List')
    expect(page).to have_selector('.new_list')
    expect(page).to have_text("Name can't be blank")
  end

  it 'allows a user to create multiple champion lists and navigate to them' do
    visit new_list_path
    fill_in 'Name', with: 'Mid Lane'
    fill_in 'Champions', with: "Katarina:C:Mid
                                Lucian:B:ADC
                                Hecarim:S:Jungle
                                Soraka:A:Support
                                Jax:A:Top"
    click_on('Create List')
    visit lists_path
    @list_a = List.find_by(name: 'Mid Lane')
    expect(page).to have_selector(
      "#list_#{@list_a.id} .name", text: 'Mid Lane'
    )
    expect(page).to have_selector(
      "#list_#{@list_a.id} .size", text: '5'
    )

    visit new_list_path
    fill_in 'Name', with: 'Top Lane'
    fill_in 'Champions', with: "Katarina:C:Mid
                                Lucian:B:ADC
                                Hecarim:S:Jungle
                                Soraka:A:Support
                                Jax:A:Top"
    click_on('Create List')

    visit lists_path
    @list_b = List.find_by(name: 'Top Lane')
    expect(page).to have_selector(
      "#list_#{@list_b.id} .name", text: 'Top Lane'
    )
    expect(page).to have_selector(
      "#list_#{@list_b.id} .size", text: '5'
    )

    visit lists_path
    @list_a = List.find_by(name: 'Mid Lane')
    expect(page).to have_selector(
      "#list_#{@list_a.id} .name", text: 'Mid Lane'
    )
    expect(page).to have_selector(
      "#list_#{@list_a.id} .size", text: '5'
    )
  end

  it 'does not allow user to create an invalid list, revert to new list page' do
    visit new_list_path
    fill_in 'Name', with: 'Mid Lane'
    fill_in 'Champions', with: 'Zed'
    click_on('Create List')
    expect(page).to have_selector('.new_list')
    expect(page).to have_text('Champions is invalid')
  end
end
