require 'nokogiri'

class Correios::CEP::XmlLoader::Nokogiri < Correios::CEP::XmlLoader
  def parse(xml)
    ::Nokogiri::XML(xml)
  end

  def find_node(nodes = parsed.children, name)
    node = nodes.last
    if node
      return nil unless node.element?
      return node if node.name == name

      find_node(node.children, name)
    end
  end

  def children_for(node)
    node.children
  end

  def text_for(element)
    element.text.to_s
  end
end
