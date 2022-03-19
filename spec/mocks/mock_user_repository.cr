# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https: //opensource.org/licenses/MIT.

require "../../src/model/user/abstract_user_repository"

# Implementation of `Octobur::Model::AbstractUserRepository` with a Hash as the backing
# storage.
#
# Used for mocking the database in tests.
@[ADI::Register]
class Octobur::Spec::MockUserRepository < Octobur::Model::AbstractUserRepository
  @storage : Hash(Int64, Octobur::Model::User) = Hash(Int64, Octobur::Model::User).new

  def insert(user : Octobur::Model::User) : Nil
    id : Int64 = (@storage.size + 1).to_i64
    created_at : Time = Time.utc

    user.before_save
    @storage[id] = user
    user.after_create(id, created_at)
  end

  def find(id : Int64) : Octobur::Model::User?
    @storage[id]?
  end

  def exists(user : Octobur::Model::User) : Bool
    false
  end

  def update(user : Octobur::Model::User) : Nil
    @storage[user.id] = user
  end

  def delete(id : Int64) : Nil
    @storage.delete(user.id)
  end
end
