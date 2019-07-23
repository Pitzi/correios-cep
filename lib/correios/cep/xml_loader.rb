# frozen_string_literal: true

module Correios
  module CEP
    class XmlLoader
      class << self
        attr_accessor :default_implementation

        def parse(xml)
          self.default_implementation.new(xml)
        end
      end

      attr_reader :parsed

      def initialize(xml)
        @parsed = parse(xml)
      end

      def parse(xml)
        raise NotImplementedError
      end

      def find_node(name)
        raise NotImplementedError
      end

      def children_for(node)
        raise NotImplementedError
      end

      def text_for(node)
        raise NotImplementedError
      end
    end
  end
end

Correios::CEP::XmlLoader.default_implementation = if RUBY_PLATFORM =~ /java/
  require_relative 'xml_loader/nokogiri'
  Correios::CEP::XmlLoader::Nokogiri
else
  require_relative 'xml_loader/ox'
  Correios::CEP::XmlLoader::Ox
end
