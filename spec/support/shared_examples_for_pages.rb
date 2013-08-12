require "spec_helper"

shared_examples "a page header" do
  it { should have_link "Home", :href => root_path }
  it { should have_link "Users" }
  it { should have_link "Sign in", :href => signin_path }
end

shared_examples "a page footer" do
  it { should have_link "About", :href => about_path }
  it { should have_link "Contact", :href => contact_path }
end