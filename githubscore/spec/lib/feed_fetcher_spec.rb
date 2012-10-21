require 'spec_helper'

describe FeedFetcher do
  subject { described_class.new FolderHTTPAdapter }

  it "has Net::HTTP as default adapter" do
    described_class.new.adapter.should == HTTPI::Adapter::NetHTTP
  end

  describe :fetch do
    it "returns array of activity for given user" do
      feed = subject.fetch('loz')
      feed.should have(30).items
      entry = feed.first
      entry.keys.should == ["actor", "created_at", "actor_attributes", "public", "type", "repository", "payload", "url"]
    end
  end
end
