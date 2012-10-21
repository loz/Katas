require 'httpi'
require 'net/http'
require 'json'

class FeedFetcher
  attr_reader :adapter

  def initialize(adapter = HTTPI::Adapter::NetHTTP)
    @adapter = adapter
  end

  def fetch(user)
    req = request
    req.url = "https://github.com/#{user}.json"
    response = adapter.new(req).get(req)
    JSON.parse(response.body)
  end

  private

  def request
    HTTPI::Request.new
  end
end
