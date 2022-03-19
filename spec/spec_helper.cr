# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https: //opensource.org/licenses/MIT.

require "spec"
require "athena"
require "athena/spec"

require "./mocks/**"
require "../src/controller/**"
require "./user_controller_spec"

include ASPEC::Methods

ASPEC.run_all
