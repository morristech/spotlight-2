require 'spec_helper'

describe Spotlight::Analytics::Ga do
  it "should not be enabled without configuration" do
    expect(described_class.enabled?).to be_falsey
  end
end