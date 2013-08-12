require 'spec_helper'
require "support/shared_examples_for_pages"

describe "Authentication" do
  subject { page }

  describe "Signin page" do
    before { visit signin_path }

    it { should have_content "Sign in" }
    it { should have_title "Bulletin Board | Sign in" }
    it_should_behave_like "a page header"
    it_should_behave_like "a page footer"
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title "Sign in" }
      it { should have_selector "div.alert.alert-danger", :text => "Invalid" }
    end

    describe "with valid information" do
      let(:user) { create(:user) }
      before do
        fill_in "Login", :with => user.login.upcase
        fill_in "Password", :with => user.password
        click_button "Sign in"
      end

      it { should_not have_title "Sign in" }
      it { should have_content user.login }
      it { should have_link "Profile", :href => user_path(user) }
      it { should have_link "Edit profile" }
      it { should have_link "Sign out" }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link "Sign in", :href => signin_path }
      end
    end
  end
end
