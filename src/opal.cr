# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena"

module Opal
  VERSION     = {{ `shards version "#{__DIR__}"`.chomp.stringify.downcase }}
  SERVER_HOST = ENV["OPAL_SERVER_HOST"]? || "127.0.0.1"
  SERVER_PORT = (ENV["OPAL_SERVER_PORT"]? || 3000).to_i

  ATH.run SERVER_PORT, SERVER_HOST
end
