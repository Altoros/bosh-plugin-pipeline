require 'git'

module Bosh
  module PluginGenerator
    module Helpers

      attr_accessor :generator_options, :lib_folder, :plugin_folder, :commands_folder
      extend Forwardable
      def_delegator :@generator, :generate

      def extract_options(plugin_name)
        generator_options[:author] = options[:author] || Git.global_config["user.name"]
        generator_options[:email]  = options[:email]  || Git.global_config["user.email"]
        generator_options[:license] = options[:license]
        generator_options[:description] = options[:description] || ''
        generator_options[:full_plugin_name]  = full_plugin_name(plugin_name)
        generator_options[:short_plugin_name] = short_plugin_name(plugin_name)
        generator_options[:class_name] = generator_options[:short_plugin_name].split('_').collect(&:capitalize).join
        @lib_folder      = File.join('.', 'lib', 'bosh')
        @plugin_folder   = File.join(lib_folder, generator_options[:short_plugin_name])
        @commands_folder = File.join(lib_folder, 'cli', 'commands')
        @generator = Bosh::PluginGenerator::Generator.new(generator_options, source_folder: File.expand_path("../../../../templates", __FILE__))
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

      def full_plugin_name(plugin_name)
        separator = plugin_name.include?('_') ? '_' : '-'
        plugin_name.start_with?('bosh') ? ['bosh', separator, plugin_name].join('') : plugin_name
      end

      def short_plugin_name(plugin_name)
        plugin_name.gsub(/^bosh[_-]/, '')
      end

      def generator_options
      	@generator_options ||= {}
      end

      def license?
        !!generator_options[:license]
      end

      def generate_command_class
        generate('cli/commands/command.rb.erb', File.join(commands_folder, "#{generator_options[:short_plugin_name]}.rb"))
      end

      def generate_helpers
        generate('plugin_folder/helpers.rb.erb', File.join(lib_folder, generator_options[:short_plugin_name], 'helpers.rb'))
      end

      def generate_version
        generate('plugin_folder/version.rb.erb', File.join(lib_folder, generator_options[:short_plugin_name], 'version.rb'))
      end

      def generate_gemspec
        generate('gemspec.erb', "#{generator_options[:full_plugin_name]}.gemspec")
      end

      def generate_readme
        generate('README.md.erb', 'README.md')
      end

      def generate_license
        generate("licenses/#{generator_options[:license]}.txt", 'LICENSE')
      end

      def generate_rspec_files
        generate("licenses/#{generator_options[:license]}.txt", 'LICENSE')
      end


    end
  end
end
