require 'spec_helper'

describe "Ad pages" do
  subject { page }

  describe "index page" do
    before { visit root_path }

    it { should have_content("Bulletin Board") }
    it { should have_title("Bulletin Board") }
    it { should have_selector("a.btn.btn-large.btn-primary",
                              :text => "Sign in") }
    it { should have_selector("a.btn.btn-large.btn-primary",
                              :text => "Sign up") }
    it { should have_link("Home", :href => root_path) }
    it { should have_link("Users") }
    it { should have_link("Sign in") }
    it { should have_link("About") }
    it { should have_link("Contact") }
  end
end
