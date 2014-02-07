require "spec_helper"

feature "Feature Pages Adminstration", js:  true do
  let(:exhibit_curator) { FactoryGirl.create(:exhibit_curator) }
  let(:exhibit) { Spotlight::Exhibit.default }
  let!(:page1) {
    FactoryGirl.create(
      :feature_page,
      title: "FeaturePage1",
      exhibit: exhibit
    )
  }
  let!(:page2) {
    FactoryGirl.create(
      :feature_page,
      title: "FeaturePage2",
      exhibit: exhibit,
      display_sidebar: true
    )
  }
  before { login_as exhibit_curator }
  it "should update the page titles" do
    visit spotlight.exhibit_catalog_index_path(Spotlight::Exhibit.default)
    click_link "Feature pages"
    within("[data-id='#{page1.id}']") do
      within("h3") do
        expect(page).to have_content("FeaturePage1")
      end
      click_link "Options"
      fill_in("Page title", with: "NewFeaturePage1")
    end
    click_button "Save changes"
    expect(page).to have_content("Feature pages were successfully updated.")
    within("[data-id='#{page1.id}']") do
      within("h3") do
        expect(page).to have_content("NewFeaturePage1")
      end
    end
  end
  it "should store the display_sidebar boolean" do
    visit spotlight.exhibit_catalog_index_path(Spotlight::Exhibit.default)
    click_link "Feature pages"
    within("[data-id='#{page1.id}']") do
      click_link "Options"
      expect(field_labeled("Show sidebar")).to_not be_checked
      check "Show sidebar"
    end
    click_button "Save changes"
    within("[data-id='#{page1.id}']") do
      click_link "Options"
      expect(field_labeled("Show sidebar")).to be_checked
    end
  end

  it "should create a new home page" do
    visit spotlight.exhibit_catalog_index_path(Spotlight::Exhibit.default)
    click_link "Feature pages"

    within ".home_page" do
      click_link "Add"    
    end

    fill_in "Title", with: "Home Page Text"
    click_button "Save"

    expect(page).to have_selector "h3", text: "Exhibit Home"
  end
end