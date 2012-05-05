module GED
  class XMLBuilder
    attr_reader :indentation
    EOL = "\n"

    def initialize(node, options = {})
      @node = node
      @indentation = options[:indentation] || 0
    end

    def to_xml
      ident = ('  ' * @indentation)
      attrs = ""
      if @node.id
        attrs = %{ id="#{@node.id}"}
      end
      start_tag = "<#{@node.tag}#{attrs}>"
      end_tag = "</#{@node.tag}>"
      xml = ""
      if @node.children.empty?
        xml << ident << start_tag
        xml << @node.value if @node.value
        xml << end_tag
      else
        xml << ident << start_tag << EOL
        xml << ident << "  " << @node.value << EOL if @node.value
        @node.children.each do |child|
          child_xml = self.class.new(child, :indentation => (@indentation + 1)).to_xml
          xml << child_xml << EOL
        end
        xml << ident << end_tag
      end
      xml
    end
  end
end
