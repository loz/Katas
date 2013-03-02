class SexpWalker

  class Node
    attr_reader :children, :args, :body
    def initialize(children, args, body)
      @children = children
      @args = args
      @body = body
    end

    def line
      _, _, pos = @children
      pos[0]
    end
  end
  class Program < Node; end
  class Def < Node
    def body
      _, nodes = @body
      nodes
    end
  end

  NODES = {
    :program => Program,
    :def => Def
  }
  attr_reader :sexp

  def initialize(sexp)
    @sexp = sexp
  end

  def walk
    objectify_node(sexp)
  end

  private

  def objectify_node(node)
    token, items, args, body = node
    klass = NODES[token]
    if klass
      items = filter_void(items)
      items = map_nodes(items)
      NODES[token].new(items, args, body)
    else
      node
    end
  end

  def map_nodes(nodes)
    nodes.map do |node|
      objectify_node(node)
    end
  end

  def filter_void(items)
    items.reject {|i| i == [:void_stmt]}
  end
end
