require 'erubis'

module Bosh
  module PluginGenerator
    class Generator

      attr_accessor :context
      def initialize(context)
      	@context = context
      end

      def generate(source, target)
        folder = File.dirname(target)
        FileUtils.mkdir_p(folder)
        template = File.read(source)
        result = Erubis::Eruby.new(template).result(context)
        File.write(target, result)
      end

    end
  end
end