require 'spec_helper'

describe Spotlight::AboutPage, :type => :model do
  let(:page) { Spotlight::AboutPage.create! exhibit: FactoryGirl.create(:exhibit)  }
  it {is_expected.not_to be_feature_page}
  it {is_expected.to be_about_page}
  it "should display the sidebar" do
    expect(page.display_sidebar?).to be_truthy
  end
  it "should force the sidebar to display (we do not provide an interface for setting this to false)" do
    expect(page.display_sidebar?).to be_truthy
    page.display_sidebar = false
    page.save
    expect(page.display_sidebar?).to be_truthy
  end
end
