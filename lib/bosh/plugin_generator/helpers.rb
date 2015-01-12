require 'git'

module Bosh
  module PluginGenerator
    module Helpers

      attr_accessor :plugin_name, :plugin_folder, :lib_folder, :helpers_folder, :commands_folder

      extend Forwardable
      def_delegator :@generator, :generate

      def extract_options(plugin_name)
        @plugin_name     = plugin_name
        @license_type    = options[:license]
        @lib_folder      = File.join(plugin_name, 'lib', 'bosh')
        @spec_folder     = File.join(plugin_name, 'spec')
        @helpers_folder  = File.join(lib_folder, short_plugin_name)
        @commands_folder = File.join(lib_folder, 'cli', 'commands')

        context = {}
        context[:author]  = options[:author] || Git.global_config["user.name"]
        context[:email]   = options[:email]  || Git.global_config["user.email"]
        context[:license] = options[:license]
        context[:description] = options[:description] || ''
        context[:full_plugin_name]  = full_plugin_name
        context[:short_plugin_name] = short_plugin_name
        context[:class_name] = short_plugin_name.split('_').collect(&:capitalize).join

        puts context

        templates_folder = File.expand_path("../../../../templates", __FILE__)
        @generator = Bosh::PluginGenerator::Generator.new(context, source_folder: templates_folder)
      end
      
      def generate_files
        generate_command_class
        generate_helpers
        generate_version
        generate_gemspec
        generate_readme
        generate_license if license?
      end      

      private

      def full_plugin_name
        return @full_plugin_name if @full_plugin_name
        separator = plugin_name.include?('_') ? '_' : '-'
        @full_plugin_name = plugin_name.start_with?('bosh') ? plugin_name : ['bosh', plugin_name].join(separator)
      end

      def short_plugin_name
        @short_plugin_name ||= plugin_name.gsub(/^bosh[_-]/, '')
      end

      def license?
        !!@license_type
      end

      def generate_command_class
        generate('cli/commands/command.rb.erb', File.join(commands_folder, "#{short_plugin_name}.rb"))
      end

      def generate_helpers
        generate('helpers_folder/helpers.rb.erb', File.join(helpers_folder, 'helpers.rb'))
      end

      def generate_version
        generate('helpers_folder/version.rb.erb', File.join(helpers_folder, 'version.rb'))
      end

      def generate_gemspec
        generate('gemspec.erb', "#{full_plugin_name}.gemspec")
      end

      def generate_readme
        generate('README.md.erb', 'README.md')
      end

      def generate_license
        generate("licenses/#{@license_type}.txt", 'LICENSE')
      end

      def generate_rspec_files
        generate("licenses/#{@license_type}.txt", 'LICENSE')
      end

    end
  end
end
