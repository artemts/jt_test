require 'spec_helper'

describe User do
  let(:user) { build(:user) }

  subject { user }

  it { should respond_to(:login) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when login is not present" do
    before { user.login = "" }
    it { should_not be_valid }
  end

  describe "when login is too short" do
    before { user.login = "a" }
    it { should_not be_valid }
  end

  describe "when login is too long" do
    before { user.login = "a" * 17 }
    it { should_not be_valid }
  end

  describe "when login format is invalid" do
    it "should not be valid" do
      logins = ["example user", "some,user", "123", "#otheruser1"]
      logins.each do | invalid_login |
        user.login = invalid_login
        expect(user).not_to be_valid
      end
    end
  end

  describe "when login format is valid" do
    it "should be valid" do
      logins = %w(ExampleUser some_user 123a _OTHERuser1)
      logins.each do | valid_login |
        user.login = valid_login
        expect(user).to be_valid
      end
    end
  end

  describe "when login is already taken" do
    before do
      create(:user, :login => user.login.upcase,
                    :email => "otheruser@example.com")
    end
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should not be valid" do
      emails = ["user@example", "some user@foo.com",
                "user_at_foo.org", "other.user@foo."]
      emails.each do | invalid_email |
        user.email = invalid_email
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      emails = %w(user@example.com some.user@foo.com user11@mail.org)
      emails.each do | valid_email |
        user.email = valid_email
        expect(user).to be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      create(:user, :login => "otheruser", :email => user.email.upcase)
    end
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      user.password = user.password_confirmation = ""
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { user.password = user.password_confirmation = "a" * 7 }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(:login => user.login) }

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    describe "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end
  end
end
