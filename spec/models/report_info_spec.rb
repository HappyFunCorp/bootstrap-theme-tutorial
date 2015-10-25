require 'rails_helper'

RSpec.describe ReportInfo, type: :model do
  before( :each ) do
    @r = ReportInfo.new
  end

  context "emails" do
    it "should give an error when there are no emails" do
      @r.save

      expect( @r.errors[:emails] ).to_not be_blank
    end

    it "should accept something with a @ as a valid email" do
      @r.emails = "a@b"
      @r.save

      expect( @r.errors[:emails] ).to be_blank
    end

    it "should reject something without an @" do
      @r.emails = "a@b, c"
      @r.save

      expect( @r.errors[:emails] ).to_not be_blank      
    end


    it "should reformat a comma seperated list of emails" do
      @r.emails = "wschenk@gmail.com, will@happyfuncorp.com,will@example.com          ,    will@facebook.com"
      @r.save

      expect( @r.emails ).to eq( "wschenk@gmail.com, will@happyfuncorp.com, will@example.com, will@facebook.com" )
    end
  end

  context "models" do
    it "should require at least one model" do
      @r.save
      expect( @r.errors[:models] ).to_not be_blank
    end

    it "should accept a existing model" do
      @r.models = "ReportInfo"

      @r.save

      expect( @r.errors[:models] ).to be_blank
    end

    it "should accept multiple models that exist" do
      @r.models = "ReportInfo,    Identity"

      @r.save

      expect( @r.errors[:models] ).to be_blank
      expect( @r.models ).to eq( "ReportInfo, Identity")
    end

    it "should not accept a model that doesn't exist" do
      @r.models = "ReportInfo, blahblahnothing"
      @r.save

      expect( @r.errors[:models] ).to_not be_blank
    end

    it "should let you specify a key" do
      @r.models = "ReportInfo,  InstagramPost.updated_at"
      @r.save

      expect( @r.errors[:models] ).to be_blank
    end
  end
end
