# frozen_string_literal: true

module Correios
  module CEP
    class Parser
      ADDRESS_MAP = {
        'end'          => :address,
        'bairro'       => :neighborhood,
        'cidade'       => :city,
        'uf'           => :state,
        'cep'          => :zipcode,
        'complemento'  => :complement,
        'complemento2' => :complement2,
      }.freeze

      def address(xml)
        doc = Correios::CEP::XmlLoader.parse(xml)

        return_node = doc.find_node('return')
        return {} if return_node.nil?

        address = {}
        doc.children_for(return_node).each do |element|
          address[ADDRESS_MAP[element.name]] = doc.text_for(element).force_encoding(Encoding::UTF_8) if ADDRESS_MAP[element.name]
        end

        join_complements(address)
        address
      end

      private

      def join_complements(address)
        address[:complement] = "" if address[:complement].nil?
        address[:complement] += " #{address.delete(:complement2)}"
        address[:complement].strip!
      end
    end
  end
end
