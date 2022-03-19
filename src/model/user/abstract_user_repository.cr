# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https: //opensource.org/licenses/MIT.

require "../repository"
require "./user"

abstract class Octobur::Model::AbstractUserRepository
  include Octobur::Model::Repository(Octobur::Model::User)

  abstract def exists(user : Octobur::Model::User) : Bool
end
