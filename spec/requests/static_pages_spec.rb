require 'spec_helper'
require "support/shared_examples_for_pages"

describe "Static pages" do
  let(:base_title) { "Bulletin Board" }
  subject { page }

  describe "About page" do
    before { visit about_path }

    it { should have_content("About application") }
    it { should have_title("#{base_title} | About") }
    it_should_behave_like "a page header"
    it_should_behave_like "a page footer"
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content("Contact author") }
    it { should have_title("#{base_title} | Contact") }
    it_should_behave_like "a page header"
    it_should_behave_like "a page footer"
  end
end
