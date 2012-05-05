module GED
  class Node
    attr_reader :children, :tag, :value, :id, :parent

    def initialize(options = {})
      @tag = options[:tag]
      @value = options[:value]
      @id = options[:id]
      @parent = options[:parent]
      @children = []
    end
  end
end
