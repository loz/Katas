module GED
  class XMLBuilder
    attr_reader :indentation

    def initialize(options = {})
      @indentation = options[:indentation] || 0
    end

    def to_xml
      ('  ' * @indentation) + "<thetag></thetag>"
    end
  end
end
