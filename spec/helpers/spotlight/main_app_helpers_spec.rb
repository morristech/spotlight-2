require 'spec_helper'

describe Spotlight::MainAppHelpers, :type => :helper do
  
  describe "#show_contact_form?" do
    subject { helper }
    let(:exhibit) { FactoryGirl.create :exhibit }
    let(:exhibit_with_contacts) { FactoryGirl.create :exhibit }
    context "with an exhibit with confirmed contacts" do
      before { exhibit_with_contacts.contact_emails.create(email: 'cabeer@stanford.edu').confirm! }
      before { allow(helper).to receive_messages current_exhibit: exhibit_with_contacts }
      its(:show_contact_form?) { should be_truthy }
    end

    context "with an exhibit with only unconfirmed contacts" do
      before { exhibit_with_contacts.contact_emails.build email: 'cabeer@stanford.edu' }
      before { allow(helper).to receive_messages current_exhibit: exhibit_with_contacts }
      its(:show_contact_form?) { should be_falsey }
    end
    
    
    context "with an exhibit without contacts" do
      before { allow(helper).to receive_messages current_exhibit: exhibit }
      its(:show_contact_form?) { should be_falsey }
    end
    
    context "outside the context of an exhibit" do
      before { allow(helper).to receive_messages current_exhibit: nil }
      its(:show_contact_form?) { should be_falsey }
    end
  end
end
