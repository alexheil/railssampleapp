require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the base title" do
      visit root_path
      expect(page).to have_title("Beats Realm")
    end

    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to have_title('| Home')
    end
  end
end
