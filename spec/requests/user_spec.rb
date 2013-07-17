require 'spec_helper'

describe 'User', js: true do
  let!(:post) {FactoryGirl.create(:post)}

  context "on homepage" do
    
    # before(:each) do
    #   visit root_path
    # end

    it "sees a list of recent posts titles" do
      visit root_path
      Post.recent.each do |post|
        expect(page).to have_content(post.title)
      end
      # given a user and a list of posts
      # user visits the homepage
      # user can see the posts titles
    end

    it "can not see bodies of the recent posts" do
      visit root_path
      Post.recent.each do |post|
        expect(page).to_not have_content(post.content)
      end
      # given a user and a list of posts
      # user visits the homepage
      # user should not see the posts bodies
    end
    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      click_on (post.title)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content) #Ask Jeffery Later
      # given a user and a list of posts
      # user visits the homepage
      # when a user can clicks on a post title they should be on the post show page
    end
    it "can not see the edit link" do
      visit root_path
      expect(page.has_no_link?("Edit")).to be_true
      # given a user and a list of posts
      # user visits the homepage
      # user should not see any edit links
    end
    it "can not see the delete link" do
      visit root_path
      expect(page.has_no_link?("Delete")).to be_true
      # given a user and a list of posts
      # user visits the homepage
      # user should not see any delete links
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      visit post_path(post.id)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
      # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
    it "can not see the edit link" do
      visit post_path(post.id)
      expect(page.has_no_link?("Edit post")).to be_true
      # given a user and post(s)
      # user visits the post show page
      # user should not see the post edit link
    end
    it "can not see the published flag" do
      visit post_path(post.id)
      expect(page).to_not have_content(post.is_published)
      # given a user and post(s)
      # user visits the post show page
      # user should not see the published flag content
    end
    it "can not see the Admin homepage link" do
      visit post_path(post.id)
      expect(page.has_no_link?("Admin welcome page")).to be_true
      # given a user and post(s)
      # user visits the post show page
      # user should not see the the admin homepage link
    end
  end
end
