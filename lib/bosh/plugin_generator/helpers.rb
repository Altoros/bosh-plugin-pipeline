require 'git'

module Bosh
  module PluginGenerator
    module Helpers

      def extract_options(plugin_name)
        generator_options[:author] = options[:author] || Git.global_config["user.name"]
        generator_options[:email]  = options[:email]  || Git.global_config["user.email"]
        generator_options[:license] = options.has_key?(:license)
        generator_options[:license_file] = license? ? options[:license] : nil
        generator_options[:full_plugin_name]  = full_plugin_name(plugin_name)
        generator_options[:short_plugin_name] = short_plugin_name(plugin_name)
        generator_options[:lib_folder] = File.join('.', 'lib')
        generator_options[:plugin_folder] = File.join(generator_options[:lib_folder], generator_options[:short_plugin_name])
        generator_options[:commands_folder] = File.join(generator_options[:lib_folder], 'cli', 'commands')
        generator_options[:plugin_class_name] = generator_options[:short_plugin_name].split('_').collect(&:capitalize).join
      end

      def full_plugin_name(plugin_name)
        separator = plugin_name.include?('_') ? '_' : '-'
        plugin_name.starts_with?('bosh') ? ['bosh', separator, plugin_name].join('') : plugin_name
      end

      def short_plugin_name(plugin_name)
        plugin_name.gsub(/^bosh[_-]/, '')
      end

      def generator_options
      	@generator_options ||= {}
      end

      def license?
        !!plugin_options[:license]
      end

      def generate_files
        generate_command_class
        generate_helpers
        generate_version
        generate_gemspec
        generate_readme
        generate_license if license?
      end

      def generate_command_class
        generate('command_class.rb', "lib/bosh/cli/commands/#{generator_options[:namespace]}.rb")
      end

      def generate_helpers
        generate('helpers.rb', 'lib/bosh/cli/commands')
      end
      def generate_version
      def generate_gemspec
      def generate_readme
      def generate_license


    end
  end
end
