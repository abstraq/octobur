# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena-dependency_injection"
require "pg"

require "../constants"
require "./storage_provider"
require "./queries/postgres_queries"

@[ADI::Register]
class Octobur::Storage::PostgresProvider < Octobur::Storage::StorageProvider
  @@database : DB::Database = DB.open Octobur::DATABASE_URL

  # :inherit:
  def create_member(username : String, email : String, password_hash : String) : Nil
    created_at = Time.utc
    @@database.exec(Octobur::Storage::Queries::Postgres::CREATE_MEMBER, username, email, created_at, password_hash)
  end

  # :inherit:
  def get_member_by_id(id : UInt32) : Octobur::Storage::Model::Member?
    @@database.query_one?(Octobur::Storage::Queries::Postgres::RETRIEVE_MEMBER_BY_ID, id, as: Octobur::Storage::Model::Member)
  end

  # :inherit
  def update_member(id : UInt32, username? : String, email : String?, password_hash : String?, active : Bool?) : Nil
    @@database.exec(Octobur::Storage::Queries::Postgres::UPDATE_MEMBER, id, username, email, password_hash, active)
  end

  # :inherit:
  def delete_member(id : UInt32) : Nil
    @@database.exec(Octobur::Storage::Queries::Postgres::DELETE_MEMBER, id)
  end
end
