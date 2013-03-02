class SexpWalker
  attr_reader :sexp

  def initialize(sexp)
    @sexp = sexp
  end

  def to_hash
    hashify_node(sexp)
  end

  private

  def hashify_node(node)
    token, items = node
    if items.is_a? Array
      items = filter_void(items)
      items = map_nodes(items)
    end
    {token => items}
  end

  def map_nodes(nodes)
    nodes.map do |node|
      hashify_node(node)
    end
  end

  def filter_void(items)
    items.reject {|i| i == [:void_stmt]}
  end
end
