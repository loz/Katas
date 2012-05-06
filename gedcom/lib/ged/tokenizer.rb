module GED
  class Tokenizer
    attr_reader :tree, :current_node, :level

    def initialize
      @current_node = @tree = Node.new :tag => :gedcom
      @level = 0
    end

    def process(parsed)
      return unless parsed
      attrs = {}

      if parsed[:tag]
        attrs[:tag] = parsed[:tag].downcase.to_sym
        attrs[:value] = parsed[:value]
      else
        attrs[:id] = parsed[:id]
        attrs[:tag] = parsed[:value].downcase.to_sym
      end

      if parsed[:level] > @level
        @level = parsed[:level]
        @current_node = @current_node.children.last
      elsif parsed[:level] < @level
        while @level > parsed[:level]
          @level -= 1
          @current_node = @current_node.parent
        end
      end

      attrs[:parent] = @current_node
      new_node = Node.new(attrs)
      @current_node.children << new_node

      new_node
    end
  end
end
