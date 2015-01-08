require "bosh/plugin_generator"

module Bosh::Cli::Command
  class GeneratePlugin < Base
    include Bosh::PluginGenerate::Helpers

    # example: bosh generate plugin bosh-magic
    usage "generate plugin"
    desc "Generates folder with skeleton of new BOSH plugin."
    option "--author name", String, ""
    option "--email email", String, ""
    option "--description text", String, ""
    option "--license name", String, "type of license file included to plugin repository",
                                "(possible values mit|gpl|lgpl|mozilla|apache2)"
    def generate_plugin(plugin_name)
      extract_options(plugin_name)
      generate_files
    end

  end
end
