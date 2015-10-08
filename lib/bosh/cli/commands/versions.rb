require "bosh/bosh_version_updater"

module Bosh::Cli::Command
  class Versions < Base
    include Bosh::BoshVersionUpdater::Helpers

    # bosh latest version cf-release
    # bosh latest version

    usage "latest release version"
    desc "Outputs the latest available bosh version."
    def latest_bosh_version(plugin_name)
      latest_tag
    end

    usage "latest version"
    desc "Outputs the latest available bosh version."
    def latest_bosh_version(plugin_name)
      latest_tag
    end

  end
end
