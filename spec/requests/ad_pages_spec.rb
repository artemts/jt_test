require 'spec_helper'
require "support/shared_examples_for_pages"

describe "Ad pages" do
  subject { page }

  describe "index page" do
    before { visit root_path }

    it { should have_content "Bulletin Board" }
    it { should have_title "Bulletin Board" }
    it do
      should have_selector "a.btn.btn-large.btn-primary", :text => "Sign in"
    end
    it do
      should have_selector "a.btn.btn-large.btn-primary", :text => "Sign up"
    end
    it_should_behave_like "a page header"
    it_should_behave_like "a page footer"

    describe "as signed in user" do
      let(:user) { create(:user) }
      before { sign_in user }

      it { should have_content user.login }
      it do
        should have_selector "a.btn.btn-large.btn-primary",
                             :text => "Create ad"
      end
      it do
        should_not have_selector "a.btn.btn-large.btn-primary",
                                 :text => "Sign in"
      end
      it do
        should_not have_selector "a.btn.btn-large.btn-primary",
                                 :text => "Sign up"
      end
    end
  end
end
