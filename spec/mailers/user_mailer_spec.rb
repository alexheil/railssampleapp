require "spec_helper"

describe ArtistMailer do
  describe "account_activation" do
    let(:mail) { ArtistMailer.account_activation }

    it "renders the headers" do
      mail.subject.should eq("Account activation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "password_reset" do
    let(:mail) { ArtistMailer.password_reset }

    it "renders the headers" do
      mail.subject.should eq("Password reset")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
