require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Welcome!') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Satan!")
        FactoryGirl.create(:micropost, user: user, content: "Satanas!")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |i|
          page.should have_selector("li##{i.id}", text: i.content)
        end
      end

      describe "follower/following stats" do
        let(:other_user) {FactoryGirl.create(:user)}
        before do
          other_user.follow!(user)
          visit root_path
        end
        it { should have_link("0 followings", href: following_user_path(user))}
        it { should have_link("1 followers", href: followers_user_path(user))}
      end
    end
  end

  describe "Links page" do
    before { visit links_path }

    it { should have_selector('h1',    text: 'Links') }
    it { should have_selector('title', text: full_title('Links')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end
end