require 'spec_helper'
require "support/shared_examples_for_pages.rb"

describe "User pages" do
  subject { page }

  describe "Profile page" do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it { should have_content user.login }
    it { should have_content user.email }
    it { should have_title user.login }
  end

  describe "Signup page" do
    before { visit signup_path }

    it { should have_content "Sign up" }
    it { should have_title "Bulletin Board | Sign up" }
    it_should_behave_like "a page header"
    it_should_behave_like "a page footer"
  end

  describe "signup" do
    let(:submit) { "Create account" }
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      let(:user) { build(:user) }
      before do
        fill_in "Login", :with => user.login
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        fill_in "Confirm password", :with => user.password
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
