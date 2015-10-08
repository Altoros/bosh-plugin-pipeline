require "bosh/bosh_version_updater"

module Bosh::Cli::Command
  class BoshVersionUpdater < Base
    include Bosh::BoshVersionUpdater::Helpers

    # example: bosh generate plugin bosh-magic
    usage "update bosh version"
    desc "Updates plugin's BOSH version, runs tests and makes commit"
    option "--path [path]", String, "Path to plugin, by default uses current folder"
    option "--without-tests", "Don't run tests before commit"
    option "--without-commit", "Don't do commit after update"
    def update_bosh_version
      plugin_path = options[:path] || Dir.pwd
      gemspec_file = # find gemspec file in plugin_path

      File.read(gemspec_file)

    end

  end
end
