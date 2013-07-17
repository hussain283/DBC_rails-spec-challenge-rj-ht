require 'spec_helper'

describe User do
  let(:email) { "hussain283@gmail.com" }
  let(:password) { "testpwd" }
  let(:user1) { User.create(email: email, password: password) }

  it "should validate a User which has an email and pwd" do
    expect(user1).to be_valid
  end
  
  it "should be invalid without an email" do
    expect(User.new(password:'testpwd')).to_not be_valid
  end

  it "should be invalid without a pwd" do
    expect(User.new(email:'blah@gmail.com')).to_not be_valid
  end

  it "should be invalid with non-unique email" do
    User.create(email: "hussain283@gmail.com", password: "testpwd")
    expect(user1).to be_invalid
  end

  describe "#email" do
    it "should return email" do
      expect(user1.email).to eq(email)
    end
  end

end

