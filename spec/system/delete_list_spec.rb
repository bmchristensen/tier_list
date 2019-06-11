require 'rails_helper'

RSpec.describe 'deleting a list', type: :system do
  it 'allows a user to delete a list of champions' do
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

    visit new_list_path
    fill_in 'Name', with: 'Test Second'
    fill_in 'Champions', with: "Katarina:C:Mid
                                Lucian:B:ADC
                                Hecarim:S:Jungle
                                Soraka:A:Support
                                Jax:A:Top"
    click_on('Create List')
    visit lists_path
    @second_list = List.find_by(name: 'Test Second')
    expect(page).to have_selector("#list_#{@second_list.id} .name", text: 'Test Second')
    expect(page).to have_selector("#list_#{@second_list.id} .size", text: '5')

    click_on('Destroy', match: :first)
    expect(page).to have_no_content('Mid Lane')
    expect(page).to have_selector("#list_#{@second_list.id} .name", text: 'Test Second')
    expect(page).to have_selector("#list_#{@second_list.id} .size", text: '5')
  end
end
