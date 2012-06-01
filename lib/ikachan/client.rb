require 'uri'
require 'net/http'

module Ikachan
  class Client
    attr_reader :base_url, :listener

    def initialize(base_url, listener)
      @base_url = base_url.match(/^https?:\/\/[^\/]+\//) ? base_url : "http:\/\/#{base_url}\/"
      @listener = listener
    end

    def join(channel)
      dispatch :join, 'channel' => channel
    end

    def notice(channel, message)
      dispatch :notice, 'channel' => channel, 'message' => message
    end

    private

    def dispatch(type, params = {})
      uri = URI.parse "#{base_url}#{type.to_s}"
      Net::HTTP.post_form uri, params
    end
  end
end
