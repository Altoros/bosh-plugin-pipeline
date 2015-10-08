require "cli"
require "cli/core_ext"

module Bosh
  module BoshVersionUpdater
    include BoshExtensions
  end
end

require "bosh/bosh_version_updater/helpers"
