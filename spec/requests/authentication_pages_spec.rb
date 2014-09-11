require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit login_path }

    it { should have_content('Log in') }
    it { should have_title('Log in') }
  end

  describe "signin" do
    before { visit login_path }

      describe "with invalid information" do
        before { click_button "Log in" }

        it { should have_title('Log in') }
        it { should have_selector('div.alert.alert-danger') }
      end

      describe "after visiting another page" do
          before { visit root_path }
          it { should_not have_selector('div.alert.alert-danger') }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Log in"
      end

        it { should have_title(user.name) }
        it { should have_link('profile',     href: user_path(user)) }
        it { should have_link('log out',    href: logout_path) }
        it { should_not have_link('log in', href: login_path) }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Log in"
      end

      it { should have_title(user.name) }
      it { should have_link('profile',     href: user_path(user)) }
      it { should have_link('log out',    href: logout_path) }
      it { should_not have_link('log in', href: login_path) }
    end
  end
end
