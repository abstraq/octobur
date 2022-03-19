# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena"

require "./model/**"
require "./controller/**"

# Configure DI bindings
ADI.bind(database : DB::Database, DB.open(ENV["OCTOBUR_DATABASE_URL"]? || "postgres:///"))

SERVER_PORT = (ENV["OCTOBUR_SERVER_PORT"]? || 3000).to_i
SERVER_HOST = ENV["OCTOBUR_SERVER_HOST"]? || "127.0.0.1"
ATH.run(SERVER_PORT, SERVER_HOST)
