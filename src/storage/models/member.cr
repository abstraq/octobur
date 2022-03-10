# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "db"

# Represents a user of the forum.
struct Octobur::Storage::Model::Member
  include DB::Serializable

  # The unique identifier for the member.
  getter id : UInt32

  # The name the member is identified by.
  getter username : String

  # The email address the member uses to log in.
  #
  # A member's email address must be unique.
  getter email : String

  # The date member was created.
  getter created_at : Time

  # Creates a `Octobur::Storage::Model::Member` from its base data.
  def initialize(@id : UInt32, @username : String, email : String, @created_at : Time, @password_hash : String)
    @email = email.downcase
  end
end
