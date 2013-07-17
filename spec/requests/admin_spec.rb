require 'spec_helper'

describe 'Admin', js: true do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post) }

  context "signup" do
    
    before(:each) do
      visit new_user_path
    end

    it "logs user in and redirects to admin home upon successful signup" do
      fill_in 'user_email',   with: "user@example.com"
      fill_in 'user_password', with: "123"
      click_button "Signup"
      expect(page.has_link?("Logout")).to be_true
    end

    it "displays errors on unsuccessful signup" do
      fill_in 'user_email',   with: "hussain283@gmail.com"
      fill_in 'user_password', with: "123"
      click_button "Signup"
      expect(page).to have_content("Errors:")
    end

  end

  context "login" do
    
    before(:each) do 
      visit new_session_path
    end
    
    it "redirects to admin_root after successful login" do
      fill_in 'email',   with: "hussain283@gmail.com"
      fill_in 'password', with: "123"
      click_button "Login"
      expect(page.has_link?("Logout")).to be_true
    end
    it "displays errors on unsuccessful login" do
      fill_in 'email',   with: "hussain283@gmail.com"
      fill_in 'password', with: "1"
      click_button "Login"
      expect(page).to have_content("Invalid Username or Password")
    end

  end

  context "on admin homepage" do
    it "can see a list of recent posts" do
      visit admin_posts_path
      Post.recent.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      page.find("table").find("td:nth-child(2)").find("a:first-child").click
      expect(page).to have_content("Edit " + post.title)
    end
    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      page.find("table").find("td:nth-child(2)").find("a:nth-child(2)").click
      expect(page).to have_content(post.title)
    end
    it "can create a new post and view it" do
     visit new_admin_post_path

     expect {
       fill_in 'post_title',   with: "Hello world!"
       fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
       page.check('post_is_published')
       click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
   end

   context "editing post" do
    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      
      page.find("table").find("td:nth-child(2)").find("a:first-child").click
      page.uncheck('post_is_published')
      click_button "Save"

      expect(page).to have_content "Published: false"
      #why does using .change{post.is_published} work
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      visit admin_posts_path
      click_on(post.title)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end

    it "can see an edit link that takes you to the edit post path" do
      visit admin_post_path(post)
      expect(page.has_link? "Edit post").to be_true
      click_on("Edit post")
      expect(page).to have_content("Edit")
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit admin_post_path(post)
      expect(page.has_link? "Admin welcome page").to be_true
      click_on("Admin welcome page")
      expect(page).to have_content("Welcome to the admin panel!")
    end 
  end
end
