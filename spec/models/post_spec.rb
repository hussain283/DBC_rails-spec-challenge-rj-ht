require 'spec_helper'

describe Post do
  let(:title) { 'hoorton hears a hoo' }
  let(:content) { 'space jam is awesome' }
  let(:post1) { Post.create(title: title, content: content)}

  it "title should be automatically titleized before save" do
    expect(post1.title).to eq(title.titleize)
  end

  it "post should be unpublished by default" do
    expect(post1.is_published).to be_false
  end

  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    post.slug.should be_nil
    post.save

    post.slug.should eq "new-post"
  end
end

