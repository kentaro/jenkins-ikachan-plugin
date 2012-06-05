module Ikachan
  module Message
    attr_reader :build
    attr_reader :status
    attr_reader :color
    attr_reader :code
    attr_reader :notify

    def message
      msg = "#{build.full_display_name} - #{status} after #{build.duration_string}"

      instance = Java::jenkins::model::Jenkins.instance
      root_url = (instance && instance.root_url) || ''
      msg << " (#{root_url}/#{build.url})"

      "\x03%s%s" % [code.to_s, msg]
    end
  end

  class SuccessMessage
    include Message

    def initialize(build)
      @build  = build
      @status = 'Success'
      @color  = 'green'
      @code   = 3
      @notify = false
    end
  end

  class UnstableMessage
    include Message

    def initialize(build)
      @build  = build
      @status = 'Unstable'
      @color  = 'yellow'
      @code   = 8
      @notify = true
    end
  end

  class FailureMessage
    include Message

    def initialize(build)
      @build  = build
      @status = 'FAILURE'
      @color  = 'red'
      @code   = 4
      @notify = true
    end

    def message
      msg   = super
      items = build.change_set.items

      if items.any?
        msg << ': changed by '
        msg << items.map { |i|
          if i.respond_to? :author_name # GitChangeSet
            "@#{i.author_name}"
          else
            "@#{i.author.full_name}"
          end
        }.uniq.join(' ')
      end

      msg
    end
  end

  class NotBuiltMessage
    include Message

    def initialize(build)
      @build  = build
      @status = 'Not Built'
      @color  = 'yellow'
      @code   = 8
      @notify = true
    end
  end

  class AbortedMessage
    include Message

    def initialize(build)
      @build  = build
      @status = 'ABORTED'
      @color  = 'yellow'
      @code   = 8
      @notify = false
    end
  end
end
