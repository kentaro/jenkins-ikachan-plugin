module Ikachan
  class MessageFactory
    def self.create(build)
      case build.result
      when Result::SUCCESS
        SuccessMessage.new(build)

      when Result::UNSTABLE
        UnstableMessage.new(build)

      when Result::FAILURE
        FailureMessage.new(build)

      when Result::NOT_BUILT
        NotBuiltMessage.new(build)

      when Result::ABORTED
        AbortedMessage.new(build)
      end
    end
  end
end
