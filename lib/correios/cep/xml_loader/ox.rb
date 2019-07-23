require 'ox'

class Correios::CEP::XmlLoader::Ox < Correios::CEP::XmlLoader
  def parse(xml)
    ::Ox.parse(xml)
  end

  def find_node(nodes = parsed.nodes, name)
    node = nodes.last
    return nil unless node.is_a?(Ox::Element)
    return node if node.nil? || node.name == name

    find_node(node.nodes, name)
  end

  def children_for(node)
    node.nodes
  end

  def text_for(element)
    element.text.to_s
  end
end
