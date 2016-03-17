require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do
    visit '/television_shows/new'
    fill_in "Title", with: "The Big Bang Theory"
    fill_in "Network", with: "CBS"
    fill_in "Starting Year", with: "2007"
    fill_in "Ending Year", with: "2017"
    select "Comedy", from: "Genre"
    fill_in "Synopsis", with: "nerds"

    click_button "Add TV Show"

    expect(page).to have_content("The Big Bang Theory")
    expect(page).to have_content("CBS")
  end

  scenario "fail to add a show with invalid information" do

    visit '/television_shows/new'

    fill_in "Network", with: "CBS"
    fill_in "Starting Year", with: "2007"
    fill_in "Ending Year", with: "2017"
    fill_in "Synopsis", with: "nerds"

    click_button "Add TV Show"

    expect(page).to have_selector("input[value='CBS']")
    expect(page).to have_selector("input[value='2007']")
    expect(page).to have_selector("input[value='2017']")
    expect(page).to have_content("nerds")
    expect(page).to have_content("Title can't be blank")

  end
end
