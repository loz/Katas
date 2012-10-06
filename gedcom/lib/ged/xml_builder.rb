module GED
  class XMLBuilder
    attr_reader :indentation
    EOL = "\n"

    def initialize(node, options = {})
      @node = node
      @indentation = options[:indentation] || 0
    end

    def to_xml
      xml = ""
      if @node.children.empty?
        childless_node(xml)
      else
        parent_node(xml)
      end
      xml
    end

    private

    def attrs
      attrs = ""
      if @node.id
        attrs = %{ id="#{@node.id}"}
      end
      attrs
    end

    def ident
      ('  ' * @indentation)
    end

    def start_tag
      "<#{@node.tag}#{attrs}>"
    end

    def end_tag
      "</#{@node.tag}>"
    end

    def childless_node(xml)
      xml << ident << start_tag
      xml << @node.value if @node.value
      xml << end_tag
    end

    def parent_node(xml)
      xml << ident << start_tag << EOL
      xml << ident << "  " << @node.value << EOL if @node.value
      @node.children.each do |child|
        child_xml = self.class.new(child,
                                   :indentation => (@indentation + 1)
                                  ).to_xml
                                  xml << child_xml << EOL
      end
      xml << ident << end_tag
    end
  end
end
