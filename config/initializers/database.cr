# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "jennifer"
require "jennifer/adapter/postgres"

Jennifer::Config.read("config/database.yml", ENV["OPAL_ENV"]? || :development)
I18n.init
