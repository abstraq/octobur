# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

module Octobur
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify.downcase }}

  SERVER_HOST = ENV["OCTOBUR_SERVER_HOST"]? || "127.0.0.1"
  SERVER_PORT = (ENV["OCTOBUR_SERVER_PORT"]? || 3000).to_i

  DATABASE_URL = ENV["OCTOBUR_DATABASE_URL"]? || "postgres://postgres:postgres@localhost/postgres"
end
