require "bosh/plugin_generator"

module Bosh::Cli::Command
  class PluginGenerator < Base
    include Bosh::PluginGenerator::Helpers

    # example: bosh generate plugin bosh-magic
    usage "generate plugin"
    desc "Generates folder with skeleton of new BOSH plugin."
    option "--author name", String, "name of the owner (by default will take from git settings)"
    option "--email email", String, "email of the owner (by default will take from git settings)"
    option "--description text", String, "Short description of the plugin"
    option "--license name", String, "type of license file included to plugin repository",
                                     "(possible values mit|gpl|lgpl|apache2)"
    def generate_plugin(plugin_name)
      extract_options(plugin_name)
      generate_files
    end

  end
end
