require 'ikachan'

class IkachanPublisher < Jenkins::Tasks::Publisher

  display_name "Ikachan publisher"
  attr_reader :base_url, :channel, :ikachan

  def initialize(attrs = {})
    @base_url = attrs['base_url']
    @channel  = attrs['channel']
  end

  def prebuild(build, listener)
    @ikachan = Ikachan::Client.new @base_url, listener
    @ikachan.join channel
  end

  def perform(build, launcher, listener)
    message = Ikachan::MessageFactory.create(build.native).message
    ikachan.notice channel, message
  end
end
