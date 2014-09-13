require 'spec_helper'

describe Artist do

  before do
    @artist = Artist.new(name: "Example Artist", email: "artist@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @artist }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
    before { @artist.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @artist.email = " " }
    it { should_not be_valid }
  end

  describe "when name is way too long" do
    before { @artist.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[artist@foo,com artist_at_foo.org example.artist@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @artist.email = invalid_address
        expect(@artist).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[artist@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @artist.email = valid_address
        expect(@artist).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      artist_with_same_email = @artist.dup
      artist_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      artist_with_same_email = @artist.dup
      artist_with_same_email.email = @artist.email.upcase
      artist_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @artist = Artist.new(name: "Example Artist", email: "artist@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @artist.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @artist.password = @artist.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @artist.save }
    let(:found_artist) { Artist.find_by(email: @artist.email) }

    describe "with valid password" do
      it { should eq found_artist.authenticate(@artist.password) }
    end

    describe "with invalid password" do
      let(:artist_for_invalid_password) { found_artist.authenticate("invalid") }

      it { should_not eq artist_for_invalid_password }
      specify { expect(artist_for_invalid_password).to be_false }
    end
  end
end
