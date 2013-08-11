require 'spec_helper'
require "support/shared_examples_for_pages"

shared_examples "a page bla" do
  it { should have_link("Home", root_path) }
  it { should have_link("Users", "#") }
  it { should have_link("Sign in", "#") }
end

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
    it_should_behave_like "a page bla"
    it_should_behave_like "a page footer"
  end
end
