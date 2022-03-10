# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "./models/*"

# Abstract class which is the base for StorageProviders.
# All StorageProviders must implement these methods.
abstract class Octobur::Storage::StorageProvider
  # Creates a record for an `Octobur::Storage::Model::Member` in the provider's backing storage.
  #
  # Before using this method the following should be true:
  # - The `username` should be validated and safe. No validation will be performed by this method.
  # - The `email` should be lowercase.
  # - The `password_hash` should be aa valid hash using the Argon2ID algorithm.
  abstract def create_member(username : String, email : String, password_hash : String) : Nil

  # Retrieves an `Octobur::Storage::Model::Member` by their unique id.
  #
  # Returns the member or nil if a member with the given `id` does not exist.
  abstract def get_member_by_id(id : UInt32) : Octobur::Storage::Model::Member?

  # Updates the record for the member with the given `id`.
  #
  # If all of the properties are nil this method does nothing.
  abstract def update_member(id : UInt32, username? : String, email : String?, password_hash : String?, active : Bool?) : Nil

  # Deletes the member with the given `id`.
  #
  # This method deletes all records that references this member including Posts, and Threads by the
  # member. Deactivating members should be preferred unless you wish to delete user content.
  abstract def delete_member(id : UInt32) : Nil
end
