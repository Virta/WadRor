require 'spec_helper'

describe 'Places' do

  it 'if one is returned by the API, it is shown on the page' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        [ Place.new(name: 'oljenkorsi') ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'oljenkorsi'
  end

  it 'if more than one place is returned, all are shown' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        [ Place.new(name: 'oljenkorsi'), Place.new(name: 'kumpulan kartano'),
            Place.new(name: 'vuorenpeikko')]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'oljenkorsi'
    expect(page).to have_content 'kumpulan kartano'
    expect(page).to have_content 'vuorenpeikko'
  end

  it 'if no places are found, appropriate message is shown' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'No locations in kumpula'
  end

end